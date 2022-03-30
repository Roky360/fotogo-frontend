part of '../home_page.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  List<Album>? _albums;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
          await PhotoGallery.listAlbums(mediumType: MediumType.image);
      setState(() {
        _albums = albums;
        _loading = false;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(
            child: AppWidgets.fotogoCircularLoadingAnimation(),
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              double gridWidth = (constraints.maxWidth - 60) / 3;
              double gridHeight = gridWidth + 46;
              double ratio = gridWidth / gridHeight;
              return Container(
                padding: const EdgeInsets.only(
                  bottom: pageMargin,
                  left: pageMargin,
                  right: pageMargin
                ),
                child: GridView.count(
                  childAspectRatio: ratio,
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 5.0,
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    ...?_albums?.map(
                      (album) => OpenContainer(
                        closedColor: Colors.transparent,
                        closedElevation: 0,
                        openColor: Theme.of(context).colorScheme.background,
                        openElevation: 0,
                        transitionType: ContainerTransitionType.fadeThrough,
                        openBuilder: (BuildContext context,
                                void Function({Object? returnValue}) action) =>
                            AlbumView(album),
                        closedBuilder:
                            (BuildContext context, void Function() action) {
                          return GestureDetector(
                            onTap: action,
                            child: Column(
                              children: <Widget>[
                                // album thumbnail image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color:
                                        const Color(0xFFC1D5DD).withOpacity(.8),
                                    height: gridWidth,
                                    width: gridWidth,
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      fadeInDuration:
                                          const Duration(milliseconds: 200),
                                      placeholder:
                                          MemoryImage(kTransparentImage),
                                      image: AlbumThumbnailProvider(
                                        albumId: album.id,
                                        mediumType: album.mediumType,
                                        highQuality: true,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),
                                // album name
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    album.name ?? "Unnamed Album",
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                            height: 1.2,
                                            fontSize: 13,
                                            overflow: TextOverflow.fade),
                                  ),
                                ),
                                // const SizedBox(height: 2),
                                const Spacer(),
                                // photos count
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    album.count.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                            height: 1.2,
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
