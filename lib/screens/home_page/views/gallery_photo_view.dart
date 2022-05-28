import 'package:flutter/material.dart';
import 'package:fotogo/widgets/dialogs.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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

  // late List<File>? fileImages;
  late PhotoViewController controller;
  late PageController pageController;
  late int currPageIndex;

  // late final bool usingMediums;

  @override
  void initState() {
    super.initState();

    // assert(widget.media != null || widget.fileImages != null,
    //     "Must provide media. Either a list of mediums or list of files.");

    // enter full screen mode
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    // if (widget.media == null) {
    //   fileImages = widget.fileImages;
    // } else {
    //   media = widget.media;
    // }
    // usingMediums = media == null;

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
                      context, [await media[currPageIndex].getFile()]))
              // usingMediums
              //     ? [await media![currPageIndex].getFile()]
              //     : [fileImages![currPageIndex]])),
            ],
          ),
        ],
      ),
      body: PhotoViewGallery.builder(
        pageController: pageController,
        scrollPhysics: const BouncingScrollPhysics(),
        itemCount: media.length,
        // itemCount: usingMediums ? media!.length : fileImages!.length,
        onPageChanged: (index) => currPageIndex = index,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions.customChild(
            controller: controller,
            child: Image(image: PhotoProvider(mediumId: media[index].id)
                // usingMediums
                //     ? PhotoProvider(mediumId: media![index].id)
                //     : FileImage(fileImages![index]) as ImageProvider,
                ),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.contained * 3,
          );
        },
      ),
    );
  }
}
