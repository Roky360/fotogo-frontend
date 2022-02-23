import 'package:fotogo/pages/create_album/album_schedule_data.dart';

class AlbumsService {
  Future<String> createAlbum(AlbumScheduleData data) {
    print("Title: " + data.title);
    print("Dates: " + data.dates.toString());
    return Future.delayed(
        const Duration(seconds: 1), () => "Album successfully created!");
  }
}
