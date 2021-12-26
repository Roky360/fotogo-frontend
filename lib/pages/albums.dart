import 'package:flutter/material.dart';
import 'package:fotogo/widgets/album_cover.dart';

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
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 34,
            horizontal: 28,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Albums',
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(height: 15,),
                albumCover(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
