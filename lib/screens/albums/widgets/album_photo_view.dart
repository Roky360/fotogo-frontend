import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fotogo/widgets/dialogs.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AlbumPhotoView extends StatefulWidget {
  final int index;
  final List<File> fileImages;

  const AlbumPhotoView(this.index, {Key? key, required this.fileImages})
      : super(key: key);

  @override
  State<AlbumPhotoView> createState() => _AlbumPhotoViewState();
}

class _AlbumPhotoViewState extends State<AlbumPhotoView> {
  late final List<File> media;
  late int currPageIndex;

  late PhotoViewController controller;
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    media = widget.fileImages;

    controller = PhotoViewController();
    pageController = PageController(initialPage: widget.index);
    currPageIndex = widget.index;
  }

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
              FotogoMenuItem(
                'Add to...',
                onTap: () => FotogoDialogs.showAddToDialog(
                    context, [media[currPageIndex]]),
              )
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
            child: Image(image: FileImage(media[index])),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.contained * 3,
          );
        },
      ),
    );
  }
}
