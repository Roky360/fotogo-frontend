import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/dialogs.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoView extends StatefulWidget {
  final int index;
  final List<Medium> media;

  const PhotoView(this.index, this.media, {Key? key}) : super(key: key);

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  late List<Medium> media;
  late PhotoViewController controller;
  late PageController pageController;
  late int currPageIndex;

  @override
  void initState() {
    super.initState();

    // enter full screen mode
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    controller = PhotoViewController();
    pageController = PageController(initialPage: widget.index);
    currPageIndex = widget.index;

    media = widget.media;
  }

  // Future<List<File>> getFiles(int index) async {
  //   List<File> files = List.empty(growable: true);
  //
  //   for (int i = max(0, index - 1);
  //       i < min(index + 2, widget.media.length);
  //       i++) {
  //     files.add(await widget.media[i].getFile());
  //   }
  //
  //   return files;
  // }

  @override
  void dispose() {
    super.dispose();

    // exit full screen mode
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black45, Colors.transparent],
            )),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
        actions: [
          fotogoPopupMenuButton(
            items: [
              MenuItem('Add to...', onTap: () async => FotogoDialogs.showAddToDialog(context, [await media[currPageIndex].getFile()])),
            ],
          ),
        ],
      ),
      body: PhotoViewGallery.builder(
        pageController: pageController,
        scrollPhysics: const BouncingScrollPhysics(),
        itemCount: media.length,
        onPageChanged: (index) => currPageIndex = index,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions.customChild(
            controller: controller,
            child: Image(
              image: PhotoProvider(mediumId: media[index].id),
            ),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.contained * 3,
          );
        },
      ),
    );
  }
}
