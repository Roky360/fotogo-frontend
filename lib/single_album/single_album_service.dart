import 'dart:convert';
import 'dart:io';

import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:fotogo/single_album/albums_repository.dart';
import 'package:fotogo/single_album/single_album_data.dart';

/// A service that sends requests related to single albums; manages
/// [AlbumsRepository].
class SingleAlbumService {
  final AlbumsRepository _singleAlbumRepository = AlbumsRepository();
  final UserProvider _userProvider = UserProvider();
  final ClientService _clientService = ClientService();

  static final SingleAlbumService _singleAlbumService = SingleAlbumService._();

  SingleAlbumService._();

  factory SingleAlbumService() => _singleAlbumService;

  List<SingleAlbumData> get albumsData => _singleAlbumRepository.albumsData;

  void clear() => _singleAlbumRepository.clear();

  void deleteDuplicates() {
    final Set albumInstances = {};
    List toDelete = [];

    for (final i in albumsData) {
      if (albumInstances.contains(i.data.id)) {
        toDelete.add(i);
        continue;
      }
      albumInstances.add(i.data.id);
    }

    albumsData.removeWhere((element) => toDelete.contains(element));
  }

  void getAlbumContents(String albumId) async {
    _clientService.sendRequest(AlbumSender.getAlbumContents(Request(
        requestType: RequestType.getAlbumContents,
        idToken: await _userProvider.idToken,
        args: {'album_id': albumId})));
  }

  void updateAlbumImagesToRepository(String albumId, List payload) {
    final album = albumsData[
        albumsData.indexWhere((element) => element.data.id == albumId)];
    album.imagesData = List.generate(
        payload.length,
        (index) => ImageData(
              fileName: payload[index]['file_name'],
              timestamp: DateTime.tryParse(payload[index]['timestamp']),
              containingAlbums:
                  payload[index]['containing_albums'].cast<String>(),
              tag: payload[index]['tag'],
              // data: payload[index]['data'],
              data: base64Decode(payload[index]['data']),
            ));
  }

  void updateAlbum(SingleAlbumData albumData) async {
    _clientService.sendRequest(AlbumSender.updateAlbum(Request(
        requestType: RequestType.updateAlbum,
        idToken: await _userProvider.idToken,
        args: {
          'album_data': {
            'id': albumData.data.id,
            'name': albumData.data.title,
            'date_range': [
              albumData.data.dates.start.toString().split(' ')[0],
              albumData.data.dates.end.toString().split(' ')[0],
            ],
            'last_modified': DateTime.now().toString(),
            'permitted_users': albumData.data.permittedUsers
          }
        })));
  }

  void addImagesToAlbum(String albumId, List<File> imagesToAdd) async {
    final images = [];
    for (final i in imagesToAdd) {
      images.add({
        'file_name': i.uri.pathSegments.last,
        'timestamp': '', // TODO: extract exif datetime
        'location': null,
        'tag': null,
        'data': base64Encode(await i.readAsBytes())
      });
    }

    _clientService.sendRequest(AlbumSender.addImagesToAlbum(Request(
      requestType: RequestType.addImagesToAlbum,
      idToken: await _userProvider.idToken,
      args: {'album_id': albumId, 'last_modified': DateTime.now().toString()},
      payload: images,
    )));
  }

  void updateAddedImages(String albumId, List images, DateTime lastModified) {
    final imagesData = albumsData
        .firstWhere((element) => element.data.id == albumId)
        .imagesData;

    for (final i in images) {
      imagesData?.add(ImageData(
          fileName: i['file_name'],
          timestamp: DateTime.tryParse(i['timestamp']),
          containingAlbums: [albumId],
          data: base64Decode(i['data'])));
    }

    albumsData
        .firstWhere((element) => element.data.id == albumId)
        .data
        .lastModified = lastModified;
  }

  void removeImagesFromAlbum(String albumId, List<String> imagesIds) async {
    _clientService.sendRequest(AlbumSender.removeImagesFromAlbum(Request(
      requestType: RequestType.removeImagesFromAlbum,
      idToken: await _userProvider.idToken,
      args: {'album_id': albumId, 'last_modified': DateTime.now().toString()},
      payload: imagesIds,
    )));
  }

  void updateRemovedImages(
      String albumId, List imageIds, DateTime lastModified) {
    final imagesData = albumsData
        .firstWhere((element) => element.data.id == albumId)
        .imagesData;

    for (final i in imageIds) {
      imagesData?.removeWhere((element) => element.fileName == i.toString());
    }

    albumsData
        .firstWhere((element) => element.data.id == albumId)
        .data
        .lastModified = lastModified;
  }

  /// [RequestType] is passed to decide which bloc called the function.
  void deleteAlbum(String albumId) async {
    _clientService.sendRequest(AlbumSender.deleteAlbum(Request(
        requestType: RequestType.deleteAlbum,
        idToken: await _userProvider.idToken,
        args: {'album_id': albumId})));
  }

  // EXTERNAL

  void extDeleteAlbum(String albumId) async {
    _clientService.sendRequest(AlbumSender.extDeleteAlbum(Request(
        requestType: RequestType.extDeleteAlbum,
        idToken: await _userProvider.idToken,
        args: {
          'album_id': albumId,
          'last_modified': DateTime.now().toString()
        })));
  }

  void extAddImagesToAlbum(String albumId, List<File> imagesToAdd) async {
    final images = [];
    for (final i in imagesToAdd) {
      images.add({
        'file_name': i.uri.pathSegments.last,
        'timestamp': '', // TODO: extract exif datetime
        'location': null,
        'tag': null,
        'data': base64Encode(await i.readAsBytes())
      });
    }

    _clientService.sendRequest(AlbumSender.addImagesToAlbum(Request(
      requestType: RequestType.extAddImagesToAlbum,
      idToken: await _userProvider.idToken,
      args: {'album_id': albumId, 'last_modified': DateTime.now().toString()},
      payload: images,
    )));
  }
}
