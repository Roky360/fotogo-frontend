import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/pages/albums/album_content_page.dart';
import 'package:fotogo/pages/albums/widgets/album_cover.dart';

import '../../widgets/section.dart';
import 'album_data.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        physics: const ScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(pageMargin),
            child: Row(
              children: [
                Text(
                  'Albums',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.sort),
                )
              ],
            ),
          ),
          FotogoSection(
            title: 'Scheduled',
            body: Column(
              children: [
                Column(
                  children: List.generate(4, (index) {
                    AlbumData data = AlbumData(
                      title: "Amsterdam",
                      dates: DateTimeRange(
                        start: DateTime(2019, 7, 12),
                        end: DateTime(2020, 8, 18),
                      ),
                      isShared: true,
                      tags: ['Food', 'Landscape', 'People'],
                    );

                    return Column(
                      children: [
                        OpenContainer(
                          transitionType: ContainerTransitionType.fadeThrough,
                          closedBuilder: (context, action) {
                            return GestureDetector(
                              onTap: action,
                              child: AlbumCover(
                                data: data,
                              ),
                            );
                          },
                          openBuilder: (context, action) {
                            return AlbumContentPage(data: data);
                          },
                          closedShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          transitionDuration: const Duration(milliseconds: 400),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
