import 'package:fotogo/album_details/album_details_data.dart';

class AlbumDetailsRepository {
  List<AlbumDetailsData> albumsDetailsData = List.empty(growable: true);

  void clear() {
    albumsDetailsData = List.empty(growable: true);
  }
}
