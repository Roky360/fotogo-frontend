import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/widgets/dialogs.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../single_album/bloc/single_album_bloc.dart';

class AlbumPhotoView extends StatefulWidget {
  final int index;
  final List<File> fileImages;
  final String albumId;

  const AlbumPhotoView(this.index,
      {Key? key, required this.fileImages, required this.albumId})
      : super(key: key);

  @override
  State<AlbumPhotoView> createState() => _AlbumPhotoViewState();
}

class _AlbumPhotoViewState extends State<AlbumPhotoView> {
  late final List<File> media;
  late int currPageIndex;

  late final PhotoViewController controller;
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    media = widget.fileImages;

    controller = PhotoViewController();
    pageController = PageController(initialPage: widget.index);
    currPageIndex = widget.index;

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black45));
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
    pageController.dispose();

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
        iconTheme: Theme.of(context)
            .appBarTheme
            .iconTheme
            ?.copyWith(color: Colors.white),
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
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          fotogoPopupMenuButton(
            onSelected: (val) {
              if (val == "Add to...") {
                FotogoDialogs.showAddToDialog(context, [media[currPageIndex]],
                    disabledAlbumId: widget.albumId);
              } else if (val == 'Remove from album') {
                context.read<SingleAlbumBloc>().add(RemoveImagesFromAlbumEvent(
                    widget.albumId,
                    [media[currPageIndex].uri.pathSegments.last]));
                Navigator.pop(context);
              }
            },
            items: [
              FotogoMenuItem('Add to...'),
              FotogoMenuItem('Remove from album'),
            ],
          ),
        ],
      ),
      body: PhotoViewGallery.builder(
        pageController: pageController,
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
