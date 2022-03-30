import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/models/album/album_bloc.dart';
import 'package:fotogo/services/albums_service.dart';

import 'package:fotogo/pages/create_album/album_creation_data.dart';
import 'package:fotogo/utils/string_formatting.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:fotogo/widgets/section.dart';

import 'album_schedule_data.dart';

part 'states/create_album_schedule_initial.dart';

part 'states/create_album_schedule_creating.dart';

class CreateAlbumSchedulePage extends StatelessWidget {
  final VoidCallback closePanelCallback;

  const CreateAlbumSchedulePage({Key? key, required this.closePanelCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumBloc, AlbumState>(
      listener: (context, state) {
        if (state is AlbumScheduleError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is AlbumScheduleCreated) {
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text(
          //     state.message,
          //     style:
          //         Theme.of(context).textTheme.caption?.copyWith(fontSize: 12),
          //   ),
          //   behavior: SnackBarBehavior.floating,
          //   margin: const EdgeInsets.only(bottom: 80),
          // ));
        }
      },
      builder: (context, state) {
        if (state is AlbumScheduleInitial) {
          return const CreateAlbumScheduleInitial();
        } else if (state is AlbumScheduleCreating) {
          print('creating');
          return CreateAlbumScheduleCreating(data: state.albumScheduleData);
        } else if (state is AlbumScheduleCreated) {
          print('created');
          closePanelCallback();
          return Text(
            'created',
            style: Theme.of(context).textTheme.headline5,
          );
        } else {
          // error
          return const CreateAlbumScheduleInitial();
        }
      },
    );
  }
}
