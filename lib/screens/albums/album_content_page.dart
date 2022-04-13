import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/fotogo_protocol/client.dart';
import 'package:fotogo/screens/albums/album_data.dart';
import 'package:fotogo/single_album/album_service.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:fotogo/utils/string_formatting.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:sizer/sizer.dart';

import '../../album_details/album_details_data.dart';
import '../../single_album/bloc/single_album_bloc.dart';

class AlbumContentPage extends StatefulWidget {
  final AlbumDetailsData data;

  const AlbumContentPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<AlbumContentPage> createState() => _AlbumContentPageState();
}

class _AlbumContentPageState extends State<AlbumContentPage> {
  late final AlbumDetailsData data;
  final SingleAlbumService _singleAlbumService = SingleAlbumService();

  @override
  void initState() {
    super.initState();

    data = widget.data;

    context.read<SingleAlbumBloc>().add(GetAlbumContentsEvent(data.id));
  }

  List<Widget> _getActions() {
    return [
      fotogoPopupMenuButton(items: [
        MenuItem('Delete'),
      ])
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: CustomScrollView(
          // physics: const BouncingScrollPhysics(),
          controller: ScrollController(),
          slivers: [
            SliverAppBar(
              expandedHeight: 25.h,
              foregroundColor: Colors.white,
              // foregroundColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.primary,
              // backgroundColor: Theme.of(context).colorScheme.surface,
              pinned: true,
              stretch: true,
              actions: _getActions(),
              title: Text(widget.data.title, overflow: TextOverflow.ellipsis),
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1.1,
                background: Stack(
                  children: [
                    // background image (cover image)
                    Image(
                      image: NetworkImage(data.coverImage),
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
                                formatDateRangeToString(widget.data.dates),
                                style: Theme.of(context)
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
                          // Location
                          // Row(
                          //   children: [
                          //     const Icon(
                          //       Icons.location_on_outlined,
                          //       size: 22,
                          //       color: Colors.white,
                          //     ),
                          //     const SizedBox(width: 8),
                          //     Text(
                          //       'Amsterdam, Netherlands',
                          //       style: Theme.of(context)
                          //           .textTheme
                          //           .subtitle1
                          //           ?.copyWith(
                          //               color: Colors.white,
                          //               fontSize: 15,
                          //               fontWeight: FontWeight.normal),
                          //     ),
                          //   ],
                          // ),
                          const Spacer(),
                          // shared people
                          data.permittedUsers.isNotEmpty
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
                stretchModes: const [
                  // StretchMode.zoomBackground,
                  // StretchMode.blurBackground,
                ],
              ),
            ),
            // Images
            SliverToBoxAdapter(
                child: BlocConsumer<SingleAlbumBloc, SingleAlbumState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is SingleAlbumFetched) {
                  return GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    shrinkWrap: true,
                    children: _singleAlbumService.albumsData
                        .firstWhere(
                            (element) => element.detailsData.id == data.id)
                        .imagesData
                        .asMap()
                        .entries
                        .map((entry) => Image(
                              image: entry.value.data,
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                  );
                } else {
                  // SingleAlbumError state
                  return Text((state as SingleAlbumError).message);
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
