import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/models/user_bloc/user_bloc.dart';
import 'package:fotogo/pages/albums/album_data.dart';
import 'package:fotogo/pages/create_album/album_creation_data.dart';

import '../models/server_networking/server_bloc.dart';
import '../pages/create_album_schedule/album_schedule_data.dart';

class AlbumService {
  final BuildContext context;

  AlbumService(this.context);

  Future<String> createAlbumSchedule(AlbumScheduleData data) {
    print("Title: " + data.title);
    print("Dates: " + data.dates.toString());
    return Future.delayed(
        const Duration(seconds: 0), () => "Album successfully created!");
  }

  Future<List<AlbumData>> fetchAlbumsDetails() {
    print('fetching albums...');
    // return Future.delayed(
    //     Duration.zero,
    //     () => [
    //           AlbumData(
    //             title: "Amsterdam",
    //             dates: DateTimeRange(
    //               start: DateTime(2020, 7, 12),
    //               end: DateTime(2020, 8, 18),
    //             ),
    //             isShared: true,
    //             tags: ['Food', 'Landscape', 'People'],
    //             coverImagePath: 'assets/test_images/amsterdam.jpg',
    //           ),
    //           AlbumData(
    //             title: "2nd album",
    //             dates: DateTimeRange(
    //               start: DateTime(2019, 7, 12),
    //               end: DateTime(2020, 8, 18),
    //             ),
    //             isShared: true,
    //             tags: ['Food', 'Landscape'],
    //             coverImagePath: 'assets/test_images/amsterdam.jpg',
    //           ),
    //           AlbumData(
    //             title: "Eyooo",
    //             dates: DateTimeRange(
    //               start: DateTime(2019, 7, 12),
    //               end: DateTime(2020, 8, 18),
    //             ),
    //             isShared: true,
    //             tags: ['Food', 'Landscape', 'People'],
    //             coverImagePath: 'assets/test_images/amsterdam.jpg',
    //           ),
    //         ]);

    return Future.delayed(
        const Duration(seconds: 1),
        () => List.generate(4, (index) {
              return AlbumData(
                  title: "Amsterdam",
                  dates: DateTimeRange(
                    start: DateTime(2019, 7, 12),
                    end: DateTime(2020, 8, 18),
                  ),
                  isShared: true,
                  tags: ['Food', 'Landscape', 'People'],
                  coverImagePath: 'assets/test_images/amsterdam.jpg');
            }));
  }

  Future createAlbum(AlbumCreationData data, Function(Response) callback) async {
    final idToken = await context.read<UserBloc>().idToken;
    context.read<ServerBloc>().client.createConnection(
          Request(
              requestType: RequestType.createAlbum,
              idToken: idToken,
              args: {
                'album_data': {
                  'owner_id': idToken,
                  'name': data.title,
                  'date_range': [
                    "${data.dates.start.year.toString().padLeft(4)}-${data.dates.start.month.toString().padLeft(2)}-${data.dates.start.day.toString().padLeft(2)}",
                    "${data.dates.end.year.toString().padLeft(4)}-${data.dates.end.month.toString().padLeft(2)}-${data.dates.end.day.toString().padLeft(2)}",
                  ],
                  'permitted_users': data.sharedPeople,
                }
              }),
          callback,
        );
  }
}
