import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/fotogo_protocol/client.dart';
import 'package:fotogo/screens/albums/album_data.dart';
import 'package:fotogo/single_album/album_service.dart';
import 'package:fotogo/single_album/single_album_data.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:fotogo/utils/string_formatting.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:sizer/sizer.dart';

import '../../single_album/bloc/single_album_bloc.dart';
import '../../widgets/image_picker.dart';
import '../../widgets/shared_axis_route.dart';

class AlbumContentPage extends StatefulWidget {
  final String albumId;

  const AlbumContentPage({
    Key? key,
    required this.albumId,
  }) : super(key: key);

  @override
  State<AlbumContentPage> createState() => _AlbumContentPageState();
}

class _AlbumContentPageState extends State<AlbumContentPage> {
  final SingleAlbumService _singleAlbumService = SingleAlbumService();

  SingleAlbumData get albumData =>
      _singleAlbumService.albumsData.firstWhere((element) =>
      element.data.id ==
          widget.albumId);

  late bool firstBuild;

  @override
  void initState() {
    super.initState();

    firstBuild = true;
  }

  List<Widget> _getActions(BuildContext context) {
    return [
      IconButton(onPressed: addImagesToAlbum, icon: const Icon(Icons.add)),
      fotogoPopupMenuButton(items: [
        MenuItem('Select'),
        MenuItem('Add images', onTap: addImagesToAlbum),
        MenuItem('Delete'),
      ]),
    ];
  }

  void addImagesToAlbum() async {
    final res = await Navigator.push(
        context, sharedAxisRoute(widget: const FotogoImagePicker()));
    print('mmm');
    print(res);
    // context
    //     .read<SingleAlbumBloc>()
    //     .add(AddImagesToAlbumEvent(singleAlbumData.data.id, res));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SingleAlbumBloc>(
      create: (context) => SingleAlbumBloc(),
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 25.h,
                foregroundColor: Colors.white,
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                pinned: true,
                stretch: true,
                actions: _getActions(context),
                title: Text(albumData.data.title,
                    overflow: TextOverflow.ellipsis),
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1.1,
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                  background: Stack(
                    children: [
                      // background image (cover image)
                      Image(
                        image: MemoryImage(albumData.data.coverImage),
                        // image: NetworkImage(data.coverImage),
                        alignment: Alignment.center,
                        width: 100.w,
                        fit: BoxFit.cover,
                      ),
                      // shade
                      Container(color: Colors.black.withOpacity(.3)),
                      Positioned(
                        height: 25.h - 50,
                        left: 50,
                        top: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            // Dates
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  formatDateRangeToString(
                                      albumData.data.dates),
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Spacer(),
                            // shared people
                            albumData.data.permittedUsers.isNotEmpty
                                ? const Icon(Icons.groups)
                                : const SizedBox(),
                            // // Tags & shared people
                            // SizedBox(
                            //   height: 45,
                            //   child: Row(
                            //     children: [
                            //       SizedBox(
                            //         width: 60.w,
                            //         child: SingleChildScrollView(
                            //           scrollDirection: Axis.horizontal,
                            //           child: Row(
                            //             children: List.generate(
                            //                 data.tags.length,
                            //                 (index) => Container(
                            //                       margin: const EdgeInsets.only(
                            //                           right: 8, bottom: 8),
                            //                       padding:
                            //                           const EdgeInsets.symmetric(
                            //                               vertical: 6,
                            //                               horizontal: 12),
                            //                       decoration: BoxDecoration(
                            //                         border: Border.all(
                            //                             color:
                            //                                 Colors.red.shade800),
                            //                         borderRadius:
                            //                             BorderRadius.circular(20),
                            //                         color: Colors.red.shade200,
                            //                       ),
                            //                       child: Text(
                            //                           widget.data.tags[index]
                            //                               .toString(),
                            //                           style: Theme.of(context)
                            //                               .textTheme
                            //                               .subtitle1
                            //                               ?.copyWith(
                            //                                   fontWeight:
                            //                                       FontWeight
                            //                                           .normal)),
                            //                     )),
                            //           ),
                            //         ),
                            //       ),
                            //       // const VerticalDivider(
                            //       //   thickness: 1,
                            //       //   color: Colors.black26,
                            //       //   endIndent: 5,
                            //       //   width: 12,
                            //       // ),
                            //       widget.
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Images
              SliverToBoxAdapter(
                child: BlocConsumer<SingleAlbumBloc, SingleAlbumState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is SingleAlbumInitial) {
                      if (firstBuild) {
                        firstBuild = false;
                        print('getting album images');
                        context
                            .read<SingleAlbumBloc>()
                            .add(GetAlbumContentsEvent(albumData.data
                            .id));
                      }
                      return Center(
                        child: AppWidgets.fotogoCircularLoadingAnimation(),
                      );
                    } else if (state is SingleAlbumFetched) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        ),
                        itemCount: albumData.imagesData?.length,
                        itemBuilder: (context, index) {
                          return Image(
                            image: albumData.imagesData![index].data,
                            // image: entry.value.data,
                            fit: BoxFit.cover,
                          );
                        },
                      );
                    } else {
                      // SingleAlbumError state
                      return Text((state as SingleAlbumError).message);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
