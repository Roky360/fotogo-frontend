import 'package:flutter/material.dart';
import 'package:fotogo/pages/albums/album_data.dart';
import 'package:fotogo/utils/string_formatting.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:sizer/sizer.dart';

class AlbumContentPage extends StatelessWidget {
  const AlbumContentPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final AlbumData data;

  List<Widget> _getActions() {
    return [
      // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      fotogoPopupMenuButton(
          items: [
            MenuItem('Delete'),
          ]
      )
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
              foregroundColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.surface,
              pinned: true,
              stretch: true,
              actions: _getActions(),
              title: Text(data.title, overflow: TextOverflow.ellipsis),
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1.1,
                background: Stack(
                  children: [
                    Positioned(
                      height: 25.h - 50,
                      left: 50,
                      top: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          // Text(
                          //   data.title,
                          //   style: Theme.of(context).textTheme.headline6,
                          // ),
                          const Spacer(),
                          // Dates
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                formatDateRangeToString(data.dates),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        fontSize: 15, fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Location
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Amsterdam, Netherlands',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        fontSize: 15, fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Tags & shared people
                          SizedBox(
                            height: 45,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 60.w,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                          data.tags.length,
                                          (index) => Container(
                                                margin: const EdgeInsets.only(right: 8, bottom: 8),
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 6, horizontal: 12),
                                                decoration: BoxDecoration(
                                                  border:
                                                      Border.all(color: Colors.red.shade800),
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Colors.red.shade200,
                                                ),
                                                child: Text(data.tags[index].toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        ?.copyWith(
                                                            fontWeight: FontWeight.normal)),
                                              )),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(thickness: 1, color: Colors.black26, endIndent: 5, width: 12,),
                                const Icon(Icons.share),
                              ],
                            ),
                          ),
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
              child: Column(
                children: List.generate(
                    30,
                    (index) => SizedBox(
                          width: 100.w,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(index.toString()),
                          ),
                        )),
              ),
            ),
          ],
        ),
      ),

      // body: Stack(
      //   children: [

      //     Container(
      //       // decoration: ,
      //     )
      //   ],
      // ),
    );
  }
}
