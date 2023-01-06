import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_creation/bloc/album_creation_bloc.dart';
import 'package:fotogo/config/constants/theme_constants.dart';

import 'package:fotogo/album_creation/album_creation_data.dart';
import 'package:fotogo/functions/file_handling.dart';
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
          Navigator.popUntil(context, (route) => route.isFirst);
        } else if (state is AlbumCreationMessage) {
          AppWidgets.fotogoSnackBar(context,
              content: state.message,
              icon: state.icon,
              bottomPadding: state.bottomPadding);
        }
      },
      builder: (context, state) {
        if (state is AlbumCreating) {
          return CreateAlbumCreating(data: state.albumCreationData);
        } else {
          // initial state
          return CreateAlbumInitial(images: images);
        }
      },
    );
  }
}
