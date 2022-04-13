import 'package:flutter/material.dart';
import 'package:fotogo/album_details/album_details_data.dart';
import 'package:fotogo/album_details/album_details_repository.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';

class AlbumDetailsService {
  final AlbumDetailsRepository _albumDetailsRepository =
      AlbumDetailsRepository();
  final UserProvider _userProvider = UserProvider();
  final ClientService _clientService = ClientService();

  static final AlbumDetailsService _albumDetailsService =
      AlbumDetailsService._();

  AlbumDetailsService._();

  factory AlbumDetailsService() => _albumDetailsService;

  List<AlbumDetailsData> get albumsDetailsData =>
      _albumDetailsRepository.albumsDetailsData;

  void clear() => _albumDetailsRepository.clear();

  /// The requested albums to check if they're up-to-date
  /// [{'single_album id': 'last modified datetime object'}]
  void getAlbumsDetails(Map<String, String>? requestedAlbums) async {
    // TODO:
    _clientService.sendRequest(AlbumDetailsSender.getAlbumDetails(Request(
        requestType: RequestType.getAlbumDetails,
        idToken: await _userProvider.idToken,
        args: requestedAlbums != null
            ? {
                'requested_albums': requestedAlbums,
              }
            : null)));
  }

  void updateAlbumDetailsByResponse(Response response) {
    // parse payload to List<AlbumDetailsData>
    final List<AlbumDetailsData> newAlbumDetails = [];
    for (final curr in response.payload) {
      // remove deleted albums from repo
      if (curr['owner_id'] == '') {
        _albumDetailsRepository.albumsDetailsData
            .removeWhere((element) => element.id == curr['album_id']);
        continue;
      }

      newAlbumDetails.add(AlbumDetailsData(
          id: curr['album_id'],
          title: curr['name'],
          dates: DateTimeRange(
              start: DateTime.parse(curr['date_range'][0]),
              end: DateTime.parse(curr['date_range'][1])),
          permittedUsers: curr['permitted_users'],
          coverImage: curr['cover_image'],
          lastModified: DateTime.parse(curr['last_modified'])));
    }

    // replace all "outdated" albums with new ones
    for (final curr in newAlbumDetails) {
      final replaceIndex = _albumDetailsRepository.albumsDetailsData
          .indexWhere((element) => element.id == curr.id);

      if (replaceIndex == -1) {
        // if not found, it is a new single_album - add it to the repo
        _albumDetailsRepository.albumsDetailsData.add(curr);
      } else {
        // if exists, replace the old outdated one with new updated one
        _albumDetailsRepository.albumsDetailsData.removeAt(replaceIndex);
        _albumDetailsRepository.albumsDetailsData.insert(replaceIndex, curr);
      }
    }
  }

  /// Sorts the [AlbumDetailsRepository] by the start date of each single_album.
  void sortByDates() {
    _albumDetailsRepository.albumsDetailsData.sort(
      (a, b) => a.dates.start.compareTo(b.dates.start),
    );
  }

  /// Sorts the [AlbumDetailsRepository] by the title of each single_album.
  void sortByName() {
    _albumDetailsRepository.albumsDetailsData
        .sort((a, b) => a.title.compareTo(b.title));
  }

  /// Sorts the [AlbumDetailsRepository] by the [lastModified] property of each
  /// single_album.
  void sortByLastModified() {
    _albumDetailsRepository.albumsDetailsData
        .sort((a, b) => a.lastModified.compareTo(b.lastModified));
  }
}
