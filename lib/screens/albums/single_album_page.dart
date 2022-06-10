import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/functions/file_handling.dart';
import 'package:fotogo/screens/albums/widgets/album_photo_view.dart';
import 'package:fotogo/single_album/single_album_data.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:fotogo/utils/string_formatting.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:sizer/sizer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../config/constants/theme_constants.dart';
import '../../single_album/bloc/single_album_bloc.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/image_picker.dart';
import '../../widgets/shared_axis_route.dart';

class SingleAlbumPage extends StatelessWidget {
  final String albumId;

  const SingleAlbumPage({Key? key, required this.albumId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SingleAlbumBloc>(
      create: (context) => SingleAlbumBloc(),
      child: _SingleAlbumPage(albumId: albumId),
    );
  }
}

class _SingleAlbumPage extends StatefulWidget {
  final String albumId;

  const _SingleAlbumPage({
    Key? key,
    required this.albumId,
  }) : super(key: key);

  @override
  State<_SingleAlbumPage> createState() => __SingleAlbumPageState();
}

class __SingleAlbumPageState extends State<_SingleAlbumPage> {
  final SingleAlbumService _singleAlbumService = SingleAlbumService();
  final GlobalKey _scaffoldKey = GlobalKey();
  late final GlobalKey<FormFieldState> _formKey;
  late final TextEditingController _titleController;

  late final SingleAlbumData albumData;

  late bool firstBuild;
  late bool titleEditingMode;
  late bool selectionMode;
  late List<int> selectedMedia;
  late Duration animationDuration;

  @override
  void initState() {
    super.initState();

    albumData = _singleAlbumService.albumsData
        .firstWhere((element) => element.data.id == widget.albumId);

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
      selectedMedia.clear();
    });
  }

  void cancelAllModes() {
    titleEditingMode = false;
    deselectAll();
    selectionMode = false;
  }

  void addTo() async {
    final List<File> imgFiles = [];
    for (final i in selectedMedia) {
      final img = albumData.imagesData![i];
      imgFiles.add(await writeFileToTempDirectory(img.data, img.fileName));
    }

    if (!mounted) return;
    FotogoDialogs.showAddToDialog(context, imgFiles,
        disabledAlbumId: albumData.data.id);
  }

  void deleteImages() {
    final List<String> imgFileNames =
        selectedMedia.map((e) => albumData.imagesData![e].fileName).toList();

    context
        .read<SingleAlbumBloc>()
        .add(RemoveImagesFromAlbumEvent(albumData.data.id, imgFileNames));
  }

  void pushPhotoViewRoute(int index) async {
    final imagesData = albumData.imagesData;

    if (imagesData != null) {
      final List<File> imageFiles = [];
      for (final i in imagesData) {
        imageFiles.add(await writeFileToTempDirectory(i.data, i.fileName));
      }

      if (!mounted) return;
      final route = AlbumPhotoView(
        index,
        fileImages: imageFiles,
      );
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => route));
    }
  }

  Widget _getTitle(BuildContext context) {
    if (titleEditingMode) {
      return TextFormField(
        key: _formKey,
        controller: _titleController,
        autofocus: true,
        validator: (val) {
          if (val == '') {
            return "Title must not be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Title',
          suffixIcon: IconButton(
            onPressed: onDoneEditingTitle,
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
        // add to
        IconButton(
          onPressed: addTo,
          icon: const Icon(Icons.add),
          tooltip: "Add to...",
        ),
        // delete images
        IconButton(
          onPressed: deleteImages,
          icon: const Icon(Icons.delete),
          tooltip: "Remove images",
        ),
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
        IconButton(
          onPressed: () => addImagesToAlbum(context),
          icon: const Icon(Icons.add),
          tooltip: "Add more photos",
        ),
        fotogoPopupMenuButton(items: [
          FotogoMenuItem('Select', onTap: initiateSelectionMode),
          FotogoMenuItem('Delete',
              onTap: () => context
                  .read<SingleAlbumBloc>()
                  .add(DeleteAlbumEvent(albumData.data.id))),
        ]),
      ];
    }
  }

  Widget _getLeading(BuildContext context) {
    if (titleEditingMode || selectionMode) {
      return IconButton(
        onPressed: cancelAllModes,
        icon: const Icon(Icons.close),
      );
    } else {
      return const BackButton();
    }
  }

  void addImagesToAlbum(BuildContext context) async {
    final res = await Navigator.push(
        context, sharedAxisRoute(widget: const FotogoImagePicker()));

    if (!mounted) return;
    if ((res as List<File>).isNotEmpty) {
      context
          .read<SingleAlbumBloc>()
          .add(AddImagesToAlbumEvent(albumData.data.id, res));
    }
  }

  void onDoneEditingTitle() {
    if (_formKey.currentState!.validate()) {
      // if title hasn't changed
      if (_titleController.text == albumData.data.title) {
        setState(() => titleEditingMode = false);
        return;
      }

      context
          .read<SingleAlbumBloc>()
          .add(UpdateAlbumEvent(albumData..data.title = _titleController.text));
      setState(() {
        titleEditingMode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              toolbarHeight: kToolbarHeight + 10,
              expandedHeight: 20.h,
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.background,
              pinned: true,
              stretch: true,
              actions: _getActions(context),
              leading: _getLeading(context),
              title: _getTitle(context),
              titleTextStyle: AppBarTheme.of(context)
                  .titleTextStyle
                  ?.copyWith(color: Colors.white),
              iconTheme: const IconThemeData(color: Colors.white),
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
                      image: NetworkImage(albumData.data.coverImage),
                      // image: MemoryImage(albumData.data.coverImage),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Images
            SliverToBoxAdapter(
              child: BlocConsumer<SingleAlbumBloc, SingleAlbumState>(
                listener: (context, state) {
                  if (state is SingleAlbumMessage) {
                    AppWidgets.fotogoSnackBar(context,
                        content: state.message,
                        icon: FotogoSnackBarIcon.error,
                        bottomPadding: fSnackBarPaddingFromBNB);
                  } else if (state is AlbumUpdated) {
                    setState(cancelAllModes);
                  } else if (state is SingleAlbumDeleted) {
                    Navigator.pop(context, true);
                  }
                },
                builder: (context, state) {
                  if (state is SingleAlbumInitial) {
                    if (firstBuild) {
                      firstBuild = false;
                      context
                          .read<SingleAlbumBloc>()
                          .add(GetAlbumContentsEvent(albumData.data.id));
                    }

                    return Center(
                      child: AppWidgets.fotogoCircularLoadingAnimation(),
                    );
                  } else if (state is SingleAlbumFetched ||
                      state is SingleAlbumDeleted) {
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
                              : () => pushPhotoViewRoute(
                                    index, /*_scaffoldKey.currentContext!*/
                                  ),
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
                                color: const Color(0xFFC1D5DD).withOpacity(.8),
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
                                      // image: NetworkImage(
                                      //     albumData.imagesData![index].data),
                                      image: MemoryImage(
                                          albumData.imagesData![index].data),
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
                                            color: selectedMedia.contains(index)
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
    );
  }
}
