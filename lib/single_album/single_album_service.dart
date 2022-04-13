import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/single_album/albums_repository.dart';
import 'package:fotogo/single_album/single_album_data.dart';

class SingleAlbumService {
  final AlbumsRepository _singleAlbumRepository = AlbumsRepository();
  final UserProvider _userProvider = UserProvider();
  final ClientService _clientService = ClientService();

  static final SingleAlbumService _singleAlbumService = SingleAlbumService._();

  SingleAlbumService._();

  factory SingleAlbumService() => _singleAlbumService;

  List<SingleAlbumData> get albumsData => _singleAlbumRepository.albumsData;

  void getAlbumDetails() {}

  void updateAlbum() {}

  void addImagesToAlbum() {}

  void removeImagesFromAlbum() {}

  void deleteAlbum() {}
}
