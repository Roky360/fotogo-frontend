import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/widgets/dialogs.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../single_album/external_bloc/ext_single_album_bloc.dart';

class GalleryPhotoView extends StatefulWidget {
  final int index;
  final List<Medium> media;

  // final List<File>? fileImages;

  const GalleryPhotoView(
    this.index, {
    Key? key,
    required this.media,
    /*this.fileImages*/
  }) : super(key: key);

  @override
  State<GalleryPhotoView> createState() => _GalleryPhotoViewState();
}

class _GalleryPhotoViewState extends State<GalleryPhotoView> {
  late List<Medium> media;

  late PhotoViewController controller;
  late PageController pageController;
  late int currPageIndex;

  @override
  void initState() {
    super.initState();

    media = widget.media;

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
        iconTheme: const IconThemeData(color: Colors.white),
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
              FotogoMenuItem('Add to...',
                  onTap: () async => FotogoDialogs.showAddToDialog(
                      context, [await media[currPageIndex].getFile()],
                      insideAlbum: false))
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
            child: Image(image: PhotoProvider(mediumId: media[index].id)),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.contained * 3,
          );
        },
      ),
    );
  }
}
