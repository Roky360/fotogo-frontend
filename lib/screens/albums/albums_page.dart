import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_details/album_details_service.dart';
import 'package:fotogo/album_details/bloc/album_details_bloc.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/screens/albums/single_album_page.dart';
import 'package:fotogo/screens/albums/widgets/album_cover.dart';
import 'package:fotogo/single_album/single_album_data.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:sizer/sizer.dart';

import '../../album_creation/bloc/album_creation_bloc.dart';
import '../../single_album/bloc/single_album_bloc.dart';
import '../../widgets/popup_menu_button.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  final SingleAlbumService _singleAlbumService = SingleAlbumService();
  final AlbumDetailsService _albumDetailsService = AlbumDetailsService();

  late Function sortingFilter;
  List<String> filterTitles = ['Album title', 'Most recent', 'Last modified'];
  late List<Function> filterFunctions;

  List<SingleAlbumData> get _albumsData => _singleAlbumService.albumsData;

  @override
  void initState() {
    super.initState();

    context.read<AlbumDetailsBloc>().add(const SyncAlbumsDetailsEvent());

    sortingFilter = _albumDetailsService.sortByLastModified;
    filterFunctions = [
      _albumDetailsService.sortByName,
      _albumDetailsService.sortByDates,
      _albumDetailsService.sortByLastModified,
    ];
  }

  Widget getSortDropdown() {
    return DropdownButton<Function>(
      value: sortingFilter,
      underline: const SizedBox(),
      alignment: Alignment.centerRight,
      borderRadius: BorderRadius.circular(15),
      style: Theme.of(context)
          .textTheme
          .subtitle1
          ?.copyWith(fontWeight: FontWeight.normal),
      selectedItemBuilder: (context) {
        return List.generate(
            filterTitles.length,
            (index) => Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Icon(
                        Icons.swap_vert,
                        size: 22,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        filterTitles[index],
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.5,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ],
                  ),
                ));
      },
      items: List.generate(
          filterTitles.length,
          (index) => DropdownMenuItem<Function>(
                value: filterFunctions[index],
                child: Row(
                  children: [
                    sortingFilter == filterFunctions[index]
                        ? Icon(Icons.done,
                            color: Theme.of(context).colorScheme.onSurface)
                        : const SizedBox(),
                    SizedBox(
                        width:
                            sortingFilter == filterFunctions[index] ? 10 : 33),
                    Text(
                      filterTitles[index],
                      style: sortingFilter == filterFunctions[index]
                          ? Theme.of(context).textTheme.subtitle1?.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.5,
                              color: Theme.of(context).colorScheme.onSurface)
                          : null,
                    ),
                  ],
                ),
              )),
      onChanged: (val) {
        if (sortingFilter != val) {
          setState(() {
            val!();
            sortingFilter = val;
          });
        }
      },
      icon: const Icon(null),
    );
  }

  Widget _getAlbumCovers() {
    if (_albumsData.isEmpty) {
      return Center(
        child: Column(
          children: [
            Text(
              "You don't have any albums, yet...\n"
              "Create your first one here",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 3),
            const Icon(Icons.arrow_downward)
          ],
        ),
      );
    } else {
      return Column(
        children: List.generate(
            _albumsData.length,
            (index) => Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SingleAlbumPage(
                            albumId: _albumsData[index].data.id);
                      })),
                      child: AlbumCover(
                        data: _albumsData[index].data,
                      ),
                    ),
                    // OpenContainer(
                    //   transitionType: ContainerTransitionType.fade,
                    //   transitionDuration: const Duration(milliseconds: 400),
                    //   closedElevation: 3,
                    //   closedBuilder: (context, action) {
                    //     return GestureDetector(
                    //       onTap: action,
                    //       child: AlbumCover(
                    //         data: _albumsData[index].data,
                    //       ),
                    //     );
                    //   },
                    //   openBuilder: (context, action) {
                    //     return SingleAlbumPage(
                    //         albumId: _albumsData[index].data.id);
                    //   },
                    //   closedShape: const RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(20))),
                    // ),
                    const SizedBox(height: 20),
                  ],
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<AlbumDetailsBloc>().add(const SyncAlbumsDetailsEvent());
        await Future.delayed(const Duration(milliseconds: 1000));
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(pageMargin),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Fotogo Albums",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontSize: 20),
                      ),
                      const Spacer(),
                      getSortDropdown(),

                      // fotogoPopupMenuIconButton(
                      //   icon: Icons.sort,
                      //   tooltip: 'Sort',
                      //   items: [
                      //     FotogoIconMenuItem('By title', Icons.sort_by_alpha,
                      //         onTap: () => setState(
                      //             () => _albumDetailsService.sortByName())),
                      //     FotogoIconMenuItem(
                      //         'By dates', Icons.calendar_view_day_outlined,
                      //         onTap: () => setState(
                      //             () => _albumDetailsService.sortByDates())),
                      //     FotogoIconMenuItem('By last modified', Icons.edit_outlined,
                      //         onTap: () => setState(() =>
                      //             _albumDetailsService.sortByLastModified())),
                      //   ],
                      // )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: _albumsData.isEmpty
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        MultiBlocListener(
                          listeners: [
                            BlocListener<AlbumCreationBloc, AlbumCreationState>(
                                listener: (context, state) {
                              if (state is AlbumCreated) {
                                // _insertItem(_albumsData.length - 1);
                                sortingFilter();
                                setState(() {});
                              }
                            }),
                            BlocListener<SingleAlbumBloc, SingleAlbumState>(
                                listener: (context, state) {
                              if (state is SingleAlbumDeleted ||
                                  state is AlbumUpdated) {
                                // _removeItem(state.deletedIndex);
                                setState(() {});
                              }
                            }),
                          ],
                          child:
                              BlocConsumer<AlbumDetailsBloc, AlbumDetailsState>(
                            listener: (context, state) {
                              if (state is AlbumDetailsFetched) {
                                setState(() {});
                              }
                            },
                            builder: (context, state) {
                              if (state is AlbumDetailsFetched) {
                                sortingFilter();
                                return _getAlbumCovers();
                              } else if (state is AlbumDetailsError) {
                                return Text(
                                  state.message,
                                  style: Theme.of(context).textTheme.headline6,
                                );
                              } else {
                                // initial state - loading
                                return Column(
                                  children: [
                                    AppWidgets.fotogoCircularLoadingAnimation(),
                                    SizedBox(height: 40.h)
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                        // space from the BNB
                        const SizedBox(height: 80)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
