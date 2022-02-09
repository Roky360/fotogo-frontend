import 'package:flutter/material.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/pages/albums/widgets/album_cover.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/section.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView(
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
              body: AlbumCover(),
            ),
          ],
        ),
      ),
    );
  }
}
