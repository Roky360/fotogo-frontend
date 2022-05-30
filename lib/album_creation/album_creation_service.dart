import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:fotogo/single_album/single_album_data.dart';
import 'package:fotogo/single_album/single_album_service.dart';

import '../album_details/album_data.dart';
import 'album_creation_data.dart';

/// A service for album creation.
///
/// Used by [AlbumCreationBloc].
class AlbumCreationService {
  final UserProvider _userProvider = UserProvider();
  final ClientService _clientService = ClientService();
  final SingleAlbumService _singleAlbumService = SingleAlbumService();

  static final AlbumCreationService _albumCreationService =
      AlbumCreationService._();

  AlbumCreationService._();

  factory AlbumCreationService() => _albumCreationService;

  void createAlbum(AlbumCreationData data) async {
    final images = [];
    for (final i in data.imagesFiles) {
      images.add({
        'file_name': i.uri.pathSegments.last,
        'timestamp': '',
        'location': null,
        'tag': null,
        'data': base64Encode(await i.readAsBytes())
      });
    }

    _clientService.sendRequest(AlbumCreationSender.createAlbum(Request(
      requestType: RequestType.createAlbum,
      idToken: await _userProvider.idToken,
      args: {
        'album_data': {
          'owner_id': _userProvider.id,
          'name': data.title,
          'date_range': [
            data.dateRange.start.toString().split(' ')[0],
            data.dateRange.end.toString().split(' ')[0],
          ],
          'permitted_users': data.sharedPeople,
          'last_modified': data.creationTime.toString()
        }
      },
      payload: images,
    )));
  }

  void addCreatedAlbumToRepository(Request request, Response response) {
    final Map albumDataMap = request.args['album_data'] as Map;

    _singleAlbumService.albumsData.add(SingleAlbumData(
        data: AlbumData(
            id: response.payload,
            title: albumDataMap['name'],
            dates: DateTimeRange(
                start: DateTime.parse(albumDataMap['date_range'][0]),
                end: DateTime.parse(albumDataMap['date_range'][1])),
          lastModified: DateTime.parse(albumDataMap['last_modified']),
          permittedUsers: albumDataMap['permitted_users'],
          coverImage: base64Decode(request.payload[0]['data'])
        )));
  }
}
