import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_creation/album_creation_data.dart';
import 'package:fotogo/album_creation/bloc/album_creation_bloc.dart';

import 'package:path_provider/path_provider.dart';

class Testing extends StatelessWidget {
  const Testing({Key? key}) : super(key: key);

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              BlocConsumer<AlbumCreationBloc, AlbumCreationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is AlbumCreating) {
                    return Text('creating...',
                        style: Theme.of(context).textTheme.subtitle1);
                  } else if (state is AlbumCreated) {
                    return Text('created!',
                        style: Theme.of(context).textTheme.subtitle1);
                  } else if (state is AlbumCreationError) {
                    return Text(state.message,
                        style: Theme.of(context).textTheme.subtitle1);
                  } else {
                    // initial state
                    return Text('initial',
                        style: Theme.of(context).textTheme.subtitle1);
                  }
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () async {
                    context.read<AlbumCreationBloc>().add(CreateAlbumEvent(
                        AlbumCreationData(
                            title: 'testing! wow',
                            dateRange: DateTimeRange(
                                start: DateTime(2022, 4, 1),
                                end: DateTime(2022, 4, 10)),
                            imagesFiles: [
                              await getImageFileFromAssets(
                                  'fotogo_launcher_icon.png'),
                            ],
                            sharedPeople: [],
                            creationTime: DateTime.now())));
                  },
                  child: const Text('create single_album'))
            ],
          ),
        ),
      ),
    );
  }
}
