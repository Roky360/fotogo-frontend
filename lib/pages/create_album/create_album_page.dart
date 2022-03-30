import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/models/album/album_bloc.dart';

import 'package:fotogo/pages/create_album/album_creation_data.dart';
import 'package:fotogo/pages/home_page/home_page.dart';
import 'package:fotogo/utils/string_formatting.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/image_picker.dart';
import 'package:fotogo/widgets/shared_axis_route.dart';
import 'package:photo_gallery/photo_gallery.dart';
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
    return BlocConsumer<AlbumBloc, AlbumState>(
      listener: (context, state) {
        if (state is AlbumCreationError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is AlbumCreationInitial) {
          return CreateAlbumInitial(images: images);
        }
        /*else if (state is AlbumCreationCreating) {
        print('creating');
        return CreateAlbumCreating(data: state.albumScheduleData);
      }*/
        else if (state is AlbumCreationCreated) {
          return Text(
            'created',
            style: Theme.of(context).textTheme.headline5,
          );
        } else {
          // error
          return CreateAlbumInitial(images: images);
        }
      },
    );
  }
}
