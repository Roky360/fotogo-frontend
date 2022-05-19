import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/fotogo_protocol/client.dart';
import 'package:fotogo/functions/file_handling.dart';
import 'package:fotogo/screens/albums/album_data.dart';
import 'package:fotogo/single_album/album_service.dart';
import 'package:fotogo/single_album/single_album_data.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:fotogo/utils/string_formatting.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:sizer/sizer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../single_album/bloc/single_album_bloc.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/image_picker.dart';
import '../../widgets/photo_view.dart';
import '../../widgets/shared_axis_route.dart';

class AlbumContentPage extends StatefulWidget {
  final String albumId;

  const AlbumContentPage({
    Key? key,
    required this.albumId,
  }) : super(key: key);

  @override
  State<AlbumContentPage> createState() => _AlbumContentPageState();
}

class _AlbumContentPageState extends State<AlbumContentPage> {
  final SingleAlbumService _singleAlbumService = SingleAlbumService();
  late final GlobalKey<FormFieldState> _formKey;
  late final TextEditingController _titleController;

  SingleAlbumData get albumData => _singleAlbumService.albumsData
      .firstWhere((element) => element.data.id == widget.albumId);

  late bool firstBuild;
  late bool titleEditingMode;
  late bool selectionMode;

  late List<int> selectedMedia;

  late Duration animationDuration;

  @override
  void initState() {
    super.initState();

    firstBuild = true;
    titleEditingMode = false;
    selectionMode = false;
    selectedMedia = List.empty(growable: true);

    _formKey = GlobalKey<FormFieldState>();
    _titleController = TextEditingController.fromValue(
        TextEditingValue(text: albumData.data.title));

    animationDuration = const Duration(milliseconds: 200);
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
      for (int i = 0; i < albumData.imagesData!.length; i++) {
        selectedMedia.add(i);
      }
    });
  }

  void deselectAll() {
    setState(() {
      selectedMedia = List.empty(growable: true);
    });
  }

  void addTo() async {
    final List<File> imgFiles = [];
    for (final i in selectedMedia) {
      final img = albumData.imagesData![i];
      imgFiles
          .add(await writeFileToTempDirectory(img.data.bytes, img.fileName));
    }

    FotogoDialogs.showAddToDialog(context, imgFiles);
  }

  Widget _getTitle(BuildContext context) {
    if (titleEditingMode) {
      return TextFormField(
        key: _formKey,
        controller: _titleController,
        validator: (val) {
          if (val == '') {
            return "Title must not be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Title',
          suffixIcon: IconButton(
            onPressed: () => onDoneEditingTitle(context),
            icon: const Icon(Icons.done),
            color: Colors.white,
            tooltip: "Done",
          ),
          contentPadding: const EdgeInsets.only(top: 14),
          hintStyle: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(color: Colors.white),
        cursorColor: Colors.white,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.done,
      );
    } else if (selectionMode) {
      return Text(selectedMedia.length.toString());
    } else {
      return GestureDetector(
        onTap: () => setState(() {
          _titleController.text = albumData.data.title;
          titleEditingMode = true;
        }),
        child: Text(albumData.data.title, overflow: TextOverflow.ellipsis),
      );
    }
  }

  List<Widget> _getActions(BuildContext context) {
    if (titleEditingMode) {
      return [];
    } else if (selectionMode) {
      return [
        IconButton(onPressed: addImagesToAlbum, icon: const Icon(Icons.add)),
        selectedMedia.length == albumData.imagesData!.length
            ? IconButton(
                icon: const Icon(Icons.deselect),
                tooltip: "Deselect all",
                onPressed: deselectAll,
              )
            : IconButton(
                icon: const Icon(Icons.select_all),
                tooltip: "Select all",
                onPressed: selectAll,
              )
      ];
    } else {
      return [
        IconButton(onPressed: addImagesToAlbum, icon: const Icon(Icons.add)),
        fotogoPopupMenuButton(items: [
          MenuItem('Select', onTap: initiateSelectionMode),
          MenuItem('Delete',
              onTap: () => context
                  .read<SingleAlbumBloc>()
                  .add(DeleteAlbumEvent(albumData.data.id))),
        ]),
      ];
    }
  }

  void addImagesToAlbum() async {
    final res = await Navigator.push(
        context, sharedAxisRoute(widget: const FotogoImagePicker()));
    if (res != null) {
      context
          .read<SingleAlbumBloc>()
          .add(AddImagesToAlbumEvent(albumData.data.id, res));
    }
  }

  void onDoneEditingTitle(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SingleAlbumBloc>().add(UpdateAlbumEvent(albumData));
      setState(() {
        titleEditingMode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SingleAlbumBloc>(
      create: (context) => SingleAlbumBloc(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                toolbarHeight: kToolbarHeight + 10,
                expandedHeight: 20.h,
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
                pinned: true,
                stretch: true,
                actions: _getActions(context),
                title: _getTitle(context),
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1.1,
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                  background: Stack(
                    children: [
                      // background image (cover image)
                      Image(
                        image: MemoryImage(albumData.data.coverImage),
                        alignment: Alignment.center,
                        width: 100.w,
                        fit: BoxFit.cover,
                      ),
                      // shade
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Colors.black.withOpacity(.5),
                              Colors.black.withOpacity(.3),
                            ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                      ),
                      Positioned(
                        height: 25.h - 50,
                        left: 50,
                        top: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(flex: 1),
                            // Dates
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  formatDateRangeToString(albumData.data.dates),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            const Spacer(flex: 2),
                            // shared people
                            albumData.data.permittedUsers.isNotEmpty
                                ? const Icon(Icons.groups)
                                : const SizedBox(),
                            // // Tags & shared people
                            // SizedBox(
                            //   height: 45,
                            //   child: Row(
                            //     children: [
                            //       SizedBox(
                            //         width: 60.w,
                            //         child: SingleChildScrollView(
                            //           scrollDirection: Axis.horizontal,
                            //           child: Row(
                            //             children: List.generate(
                            //                 data.tags.length,
                            //                 (index) => Container(
                            //                       margin: const EdgeInsets.only(
                            //                           right: 8, bottom: 8),
                            //                       padding:
                            //                           const EdgeInsets.symmetric(
                            //                               vertical: 6,
                            //                               horizontal: 12),
                            //                       decoration: BoxDecoration(
                            //                         border: Border.all(
                            //                             color:
                            //                                 Colors.red.shade800),
                            //                         borderRadius:
                            //                             BorderRadius.circular(20),
                            //                         color: Colors.red.shade200,
                            //                       ),
                            //                       child: Text(
                            //                           widget.data.tags[index]
                            //                               .toString(),
                            //                           style: Theme.of(context)
                            //                               .textTheme
                            //                               .subtitle1
                            //                               ?.copyWith(
                            //                                   fontWeight:
                            //                                       FontWeight
                            //                                           .normal)),
                            //                     )),
                            //           ),
                            //         ),
                            //       ),
                            //       // const VerticalDivider(
                            //       //   thickness: 1,
                            //       //   color: Colors.black26,
                            //       //   endIndent: 5,
                            //       //   width: 12,
                            //       // ),
                            //       widget.
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Images
              SliverToBoxAdapter(
                child: BlocBuilder<SingleAlbumBloc, SingleAlbumState>(
                  builder: (context, state) {
                    if (state is SingleAlbumInitial) {
                      if (firstBuild) {
                        firstBuild = false;
                        print('getting album images');
                        context
                            .read<SingleAlbumBloc>()
                            .add(GetAlbumContentsEvent(albumData.data.id));
                      }

                      return Center(
                        child: AppWidgets.fotogoCircularLoadingAnimation(),
                      );
                    } else if (state is SingleAlbumFetched) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        ),
                        itemCount: albumData.imagesData?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: selectionMode
                                ? () => toggleSelection(index)
                                : () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => PhotoView(
                                              index,
                                              fileImages: [] /*List.generate(
                                                  albumData.imagesData!.length,
                                                  (index) async {
                                                return await writeFileToTempDirectory(
                                                    albumData.imagesData![index]
                                                        .data.bytes,
                                                    albumData.imagesData![index]
                                                        .fileName);
                                              })*/,
                                            ))),
                            onLongPress: selectionMode
                                ? null
                                : () {
                                    initiateSelectionMode();
                                    selectedMedia.add(index);
                                  },
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  color:
                                      const Color(0xFFC1D5DD).withOpacity(.8),
                                  child: AnimatedScale(
                                    scale: selectionMode &&
                                            selectedMedia.contains(index)
                                        ? .8
                                        : 1,
                                    duration: animationDuration,
                                    curve: Curves.easeInOutCubicEmphasized,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        selectedMedia.contains(index) ? 15 : 0,
                                      ),
                                      child: FadeInImage(
                                        fit: BoxFit.cover,
                                        fadeInDuration:
                                            const Duration(milliseconds: 100),
                                        placeholder:
                                            MemoryImage(kTransparentImage),
                                        image:
                                            albumData.imagesData![index].data,
                                      ),
                                    ),
                                  ),
                                ),
                                // gradient cover
                                AnimatedOpacity(
                                  opacity: selectionMode &&
                                          !selectedMedia.contains(index)
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
                                        selectedMedia.contains(index)
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
                                              selectedMedia.contains(index)
                                                  ? Icons.check_circle
                                                  : Icons.circle_outlined,
                                              color:
                                                  selectedMedia.contains(index)
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
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
                          );
                        },
                      );
                    } else {
                      // SingleAlbumError state
                      return Text((state as SingleAlbumMessage).message);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
