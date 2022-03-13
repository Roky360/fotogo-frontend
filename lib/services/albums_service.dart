import 'package:flutter/material.dart';
import 'package:fotogo/pages/albums/album_data.dart';
import 'package:fotogo/pages/create_album/album_schedule_data.dart';

class AlbumService {
  Future<String> createAlbum(AlbumScheduleData data) {
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
}
