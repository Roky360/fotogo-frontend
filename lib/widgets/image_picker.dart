import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fotogo/pages/create_album/album_creation_data.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

class FotogoImagePicker extends StatefulWidget {
  const FotogoImagePicker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FotogoImagePickerState();
}

class _FotogoImagePickerState extends State<FotogoImagePicker> {
  late AlbumCreationData albumCreationData;
  List<Medium>? media;
  late List<int> selectedMedia;

  late Duration animationDuration;

  @override
  void initState() {
    super.initState();

    selectedMedia = List.empty(growable: true);

    animationDuration = const Duration(milliseconds: 200);

    WidgetsBinding.instance?.addPostFrameCallback((_) => loadImages());
  }

  void loadImages() async {
    List<Album> albums =
        await PhotoGallery.listAlbums(mediumType: MediumType.image);
    Album allAlbum = albums.firstWhere((element) => element.id == '__ALL__');
    MediaPage mediaPage = await allAlbum.listMedia();
    setState(() {
      media = mediaPage.items;
    });
  }

  void toggleSelection(int index) {
    setState(() {
      selectedMedia.contains(index)
          ? selectedMedia.remove(index)
          : selectedMedia.add(index);
    });
  }

  void selectAll() {
    setState(() {
      selectedMedia = List.empty(growable: true);
      for (int i = 0; i < media!.length; i++) {
        selectedMedia.add(i);
      }
    });
  }

  void deselectAll() {
    setState(() {
      selectedMedia = List.empty(growable: true);
    });
  }

  void onDone() async {
    List<File> images = [];

    for (var element in selectedMedia) {
      images.add(await media![element].getFile());
    }

    Navigator.pop(context, images);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMedia.isEmpty
            ? "Select items"
            : selectedMedia.length == 1
                ? "1 item selected"
                : "${selectedMedia.length} items selected"),
        // cancel selection mode
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            selectedMedia = List.empty(growable: true);
            onDone();
          },
        ),
        actions: [
          media != null && selectedMedia.length == media!.length
              ? IconButton(
                  icon: const Icon(Icons.deselect),
                  tooltip: "Deselect all",
                  onPressed: deselectAll,
                )
              : IconButton(
                  icon: const Icon(Icons.select_all),
                  tooltip: "Select all",
                  onPressed: selectAll,
                ),
          IconButton(
            icon: const Icon(Icons.done),
            tooltip: 'Done',
            onPressed: selectedMedia.isNotEmpty ? onDone : null,
          ),
        ],
      ),
      body: media == null
          ? Center(child: AppWidgets.fotogoCircularLoadingAnimation())
          : GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                ...?media
                    ?.asMap()
                    .entries
                    .map(
                      (entry) => GestureDetector(
                        onTap: () => toggleSelection(entry.key),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              color: const Color(0xFFC1D5DD).withOpacity(.8),
                              child: AnimatedScale(
                                scale:
                                    selectedMedia.contains(entry.key) ? .8 : 1,
                                duration: animationDuration,
                                curve: Curves.easeInOutCubicEmphasized,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    selectedMedia.contains(entry.key) ? 15 : 0,
                                  ),
                                  child: Hero(
                                    tag: entry.value.id,
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      fadeInDuration:
                                          const Duration(milliseconds: 200),
                                      placeholder:
                                          MemoryImage(kTransparentImage),
                                      image: ThumbnailProvider(
                                        mediumId: entry.value.id,
                                        mediumType: entry.value.mediumType,
                                        highQuality: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // gradient cover
                            AnimatedOpacity(
                              opacity:
                                  !selectedMedia.contains(entry.key) ? 1 : 0,
                              duration: animationDuration,
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    Colors.black26.withOpacity(.2),
                                    Colors.transparent
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                              ),
                            ),
                            // checkbox
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Stack(
                                  children: [
                                    selectedMedia.contains(entry.key)
                                        ? ClipOval(
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              // color: Colors.red,
                                              color: const Color(0xFFC1D5DD)
                                                  .withOpacity(.9),
                                            ),
                                          )
                                        : const SizedBox(),
                                    Icon(
                                      selectedMedia.contains(entry.key)
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      color: selectedMedia.contains(entry.key)
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
    );
  }
}
