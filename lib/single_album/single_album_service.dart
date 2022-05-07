import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
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

  void clear() => _singleAlbumRepository.clear();

  void getAlbumContents(String albumId) async {
    _clientService.sendRequest(AlbumSender.getAlbumContents(Request(
        requestType: RequestType.getAlbumContents,
        idToken: await _userProvider.idToken,
        args: {'album_id': albumId})));
  }

  void updateAlbumImagesToRepository(String albumId, List payload) {
    final album = _singleAlbumService.albumsData[_singleAlbumService.albumsData
        .indexWhere((element) => element.data.id == albumId)];
    album.imagesData = List.generate(
        payload.length,
        (index) => ImageData(
            fileName: payload[index]['file_name'],
            timestamp: DateTime.tryParse(payload[index]['timestamp']),
            containingAlbums:
                payload[index]['containing_albums'].cast<String>(),
            tag: payload[index]['tag'],
            data: MemoryImage(base64Decode(payload[index]['data']))));
  }

  void updateAlbum() {}

  void addImagesToAlbum(String albumId, List<File> imagesToAdd) {}

  void removeImagesFromAlbum() {}

  void deleteAlbum(String albumId) async {
    _clientService.sendRequest(AlbumSender.deleteAlbum(Request(
        requestType: RequestType.deleteAlbum,
        idToken: await _userProvider.idToken,
        args: {'album_id': albumId})));
  }
}
