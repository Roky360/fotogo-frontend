import 'package:fotogo/single_album/single_album_data.dart';

/// Holds all the albums of the currently logged in user.
class AlbumsRepository {
  List<SingleAlbumData> albumsData = List.empty(growable: true);

  void clear() {
    albumsData = List.empty(growable: true);
  }
}
