import 'package:flutter/material.dart';
import 'package:fotogo/pages/albums/widgets/album_cover.dart';

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
            section(
              context,
              title: 'Albums',
              body: AlbumCover(),
            ),
          ],
        ),
      ),
    );
  }
}
