import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_details/bloc/album_details_bloc.dart';
import 'package:fotogo/screens/albums/album_content_page.dart';
import 'package:fotogo/screens/albums/widgets/album_cover.dart';
import 'package:fotogo/single_album/single_album_data.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:sizer/sizer.dart';

import '../../album_creation/bloc/album_creation_bloc.dart';
import '../../single_album/bloc/single_album_bloc.dart';
import '../../widgets/section.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  final SingleAlbumService _singleAlbumService = SingleAlbumService();

  List<SingleAlbumData> get _albumsData => _singleAlbumService.albumsData;

  @override
  void initState() {
    super.initState();

    context.read<AlbumDetailsBloc>().add(const SyncAlbumsDetailsEvent());
  }

  Widget _getAlbumCovers() {
    return _albumsData.isEmpty
        // no albums
        ? Center(
            child: Column(
              children: [
                // SizedBox(height: 70.h),
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
          )
        : Column(
            children: List.generate(
                _albumsData.length,
                (index) => Column(
                      children: [
                        OpenContainer(
                          transitionType: ContainerTransitionType.fade,
                          transitionDuration: const Duration(milliseconds: 400),
                          closedElevation: 3,
                          closedBuilder: (context, action) {
                            return GestureDetector(
                              onTap: action,
                              child: AlbumCover(
                                data: _albumsData[index].data,
                              ),
                            );
                          },
                          openBuilder: (context, action) {
                            return AlbumContentPage(
                                albumId: _albumsData[index].data.id);
                          },
                          closedShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )),
            /*AnimatedList(
            key: _albumDetailsKey,
            initialItemCount: _albumsData.length,

            shrinkWrap: true,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: Column(
                  children: [
                    OpenContainer(
                      transitionType: ContainerTransitionType.fade,
                      transitionDuration: const Duration(milliseconds: 400),
                      closedElevation: 3,
                      closedBuilder: (context, action) {
                        return GestureDetector(
                          onTap: action,
                          child: AlbumCover(
                            data: _albumsData[index].data,
                          ),
                        );
                      },
                      openBuilder: (context, action) {
                        return AlbumContentPage(
                            singleAlbumData: _albumsData[index]);
                      },
                      closedShape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },*/
          );
  }

  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<AlbumDetailsBloc>().add(const SyncAlbumsDetailsEvent());
        await Future.delayed(const Duration(milliseconds: 1000));
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: FotogoSection(
          title: 'Albums',
          // sort button
          action: PopupMenuButton(
            offset: Offset(100, 100),
            elevation: 5.0,
            icon: const Icon(Icons.sort),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: StatefulBuilder(
                    builder: (_context, _setState) => CheckboxListTile(
                          value: isShow,
                          onChanged: (value) =>
                              _setState(() => isShow = value!),
                        )),
              ),
            ],
          ),
          // action: fotogoPopupMenuIconButton(
          //   icon: Icons.sort,
          //   tooltip: 'Sort',
          //   items: [
          //     IconMenuItem('By title', Icons.sort_by_alpha,
          //         onTap: () =>
          //             setState(() => _albumDetailsService.sortByName()))
          //   ],
          // ),
          body: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 83.h),
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
                        setState(() {});
                      }
                    }),
                    BlocListener<SingleAlbumBloc, SingleAlbumState>(
                        listener: (context, state) {
                      if (state is SingleAlbumDeleted) {
                        // _removeItem(state.deletedIndex);
                        setState(() {});
                      }
                    }),
                  ],
                  child: BlocConsumer<AlbumDetailsBloc, AlbumDetailsState>(
                    listener: (context, state) {
                      if (state is AlbumDetailsFetched) {
                        setState(() {});
                      }
                    },
                    builder: (context, state) {
                      print(state);
                      if (state is AlbumDetailsFetched) {
                        return _getAlbumCovers();
                      } else if (state is AlbumDetailsError) {
                        return Text(
                          state.message,
                          style: Theme.of(context).textTheme.headline6,
                        );
                      } else {
                        // initial state - loading
                        return Center(
                            child: AppWidgets.fotogoCircularLoadingAnimation());
                      }
                    },
                  ),
                ),
                // space from the BNB
                const SizedBox(height: 120)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
