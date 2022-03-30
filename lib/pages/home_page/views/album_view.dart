part of '../home_page.dart';

class AlbumView extends StatefulWidget {
  final Album album;
  late final List<File> exportedImages;

  AlbumView(this.album, {Key? key, exportedImages}) : super(key: key) {
    this.exportedImages = exportedImages ?? List.empty(growable: true);
  }

  @override
  State<StatefulWidget> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  late bool selectionMode;
  List<Medium>? media;
  late List<int> selectedMedia;

  late Duration animationDuration;

  @override
  void initState() {
    super.initState();

    selectionMode = false;
    selectedMedia = List.empty(growable: true);

    animationDuration = const Duration(milliseconds: 200);

    initAsync();
  }

  void initAsync() async {
    MediaPage mediaPage = await widget.album.listMedia();
    setState(() {
      media = mediaPage.items;
    });
  }

  void initiateSelectionMode() {
    setState(() {
      selectionMode = true;
    });
  }

  void toggleSelection(int index) {
    setState(() {
      selectedMedia.contains(index)
          ? selectedMedia.remove(index)
          : selectedMedia.add(index);
      selectionMode = selectedMedia.isNotEmpty;
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

  @override
  Widget build(BuildContext context) {
    // print(selectedMedia);
    return Scaffold(
      appBar: selectionMode
          // selection mode ENABLED
          ? AppBar(
              title: Text(selectedMedia.isEmpty
                  ? "Select items"
                  : selectedMedia.length == 1
                      ? "1 item selected"
                      : "${selectedMedia.length} items selected"),
              // cancel selection mode
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => setState(() {
                  selectedMedia = List.empty(growable: true);
                  selectionMode = false;
                }),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: selectedMedia.isNotEmpty ? () {} : null,
                ),
                selectedMedia.length == media!.length
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
              ],
            )
          // REGULAR app bar
          : AppBar(
              title: Text(
                widget.album.name ?? "Unnamed Album",
                overflow: TextOverflow.fade,
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: "Back",
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                fotogoPopupMenuButton(
                  items: [
                    MenuItem(
                      'Select',
                      onTap: initiateSelectionMode,
                    ),
                  ],
                ),
              ],
            ),
      body: GridView.count(
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
                  onTap: selectionMode
                      ? () => toggleSelection(entry.key)
                      : () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PhotoView(entry.key, media!))),
                  onLongPress: selectionMode
                      ? null
                      : () {
                          initiateSelectionMode();
                          selectedMedia.add(entry.key);
                        },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        color: const Color(0xFFC1D5DD).withOpacity(.8),
                        child: AnimatedScale(
                          scale:
                              selectionMode && selectedMedia.contains(entry.key)
                                  ? .8
                                  : 1,
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
                                placeholder: MemoryImage(kTransparentImage),
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
                            selectionMode && !selectedMedia.contains(entry.key)
                                ? 1
                                : 0,
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
                              AnimatedOpacity(
                                opacity: selectionMode ? .9 : 0,
                                duration: animationDuration,
                                child: AnimatedScale(
                                  alignment: Alignment.topLeft,
                                  scale: selectionMode ? 1 : .5,
                                  duration: animationDuration,
                                  curve: Curves.easeInOut,
                                  child: Icon(
                                    selectedMedia.contains(entry.key)
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: selectedMedia.contains(entry.key)
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                  ),
                                ),
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
