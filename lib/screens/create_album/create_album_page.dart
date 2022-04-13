import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_creation/bloc/album_creation_bloc.dart';
import 'package:fotogo/config/constants/theme_constants.dart';

import 'package:fotogo/album_creation/album_creation_data.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/image_picker.dart';
import 'package:fotogo/widgets/shared_axis_route.dart';
import 'package:sizer/sizer.dart';
import 'package:fotogo/widgets/section.dart';

part 'states/create_album_initial.dart';

part 'states/create_album_creating.dart';

class CreateAlbumPage extends StatelessWidget {
  late final List<File> images;

  CreateAlbumPage({Key? key, images}) : super(key: key) {
    this.images = images ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumCreationBloc, AlbumCreationState>(
      listener: (context, state) {
        if (state is AlbumCreated) {
          Navigator.pop(context);
        } else if (state is AlbumCreationError) {
          AppWidgets.fotogoSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is AlbumCreating) {
          return CreateAlbumCreating(data: state.albumCreationData);
          // context.read<UserBloc>().userData.albumsData.add(AlbumData(
          //     id: state.albumId,
          //     title: state.albumData.title,
          //     dates: state.albumData.dateRange,
          //     isShared: state.albumData.sharedPeople.isNotEmpty,
          //     images: state.albumData.imagesFiles
          //         .map((e) => ImageData(
          //             data: MemoryImage(e.readAsBytesSync()),
          //             fileName: '',
          //             containingAlbums: []))
          //         .toList(),
          //     tags: []));
        } else if (state is AlbumCreationError) {
          return Scaffold(
            body: Center(
              child: Text(state.message,
                  style: Theme.of(context).textTheme.subtitle1),
            ),
          );
        } else {
          // initial state
          return CreateAlbumInitial(images: images);
        }
      },
    );
  }
}
