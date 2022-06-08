import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fotogo/album_details/album_data.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:fotogo/single_album/single_album_service.dart';

import '../single_album/single_album_data.dart';

/// A service responsible for [AlbumsPage].
class AlbumDetailsService {
  final SingleAlbumService _singleAlbumService = SingleAlbumService();
  final UserProvider _userProvider = UserProvider();
  final ClientService _clientService = ClientService();
  late Function currSortingFilter;

  static final AlbumDetailsService _albumDetailsService =
      AlbumDetailsService._();

  AlbumDetailsService._() {
    currSortingFilter = sortByLastModified;
  }

  factory AlbumDetailsService() => _albumDetailsService;

  int deleteAlbum(String albumId) {
    int index = _singleAlbumService.albumsData
        .indexWhere((element) => element.data.id == albumId);
    _singleAlbumService.albumsData.removeAt(index);
    return index;
    // _singleAlbumService.albumsData
    //   .removeWhere((element) => element.data.id == albumId);
  }

  void clear() => _singleAlbumService.clear();

  /// The requested albums to check if they're up-to-date
  /// [{'single_album id': 'last modified datetime object'}]
  void syncAlbumsDetails(Map<String, String>? requestedAlbums) async {
    // TODO:
    _clientService.sendRequest(AlbumDetailsSender.syncAlbumDetails(Request(
        requestType: RequestType.syncAlbumDetails,
        idToken: await _userProvider.idToken,
        args: requestedAlbums != null
            ? {
                'requested_albums': requestedAlbums,
              }
            : null)));
  }

  void updateAlbumDetailsByResponse(Response response) {
    // parse payload to List<AlbumDetailsData>
    final List<AlbumData> newAlbumDetails = [];
    for (final curr in response.payload) {
      // remove deleted albums from repo
      if (curr['owner_id'] == '') {
        _singleAlbumService.albumsData
            .removeWhere((element) => element.data.id == curr['album_id']);
        continue;
      }

      newAlbumDetails.add(AlbumData(
          id: curr['album_id'],
          title: curr['name'],
          dates: DateTimeRange(
              start: DateTime.parse(curr['date_range'][0]),
              end: DateTime.parse(curr['date_range'][1])),
          permittedUsers: curr['permitted_users'].cast<String>(),
          // coverImage: base64Decode(curr['cover_image']),
          coverImage: curr['cover_image'],
          lastModified: DateTime.parse(curr['last_modified'])));
    }

    // replace all "outdated" albums with new ones
    for (final curr in newAlbumDetails) {
      final replaceIndex = _singleAlbumService.albumsData
          .indexWhere((element) => element.data.id == curr.id);

      if (replaceIndex == -1) {
        // if not found, it is a new single_album - add it to the repo
        _singleAlbumService.albumsData.add(SingleAlbumData(data: curr));
      } else {
        // if exists, replace the old outdated one with new updated one
        _singleAlbumService.albumsData.removeAt(replaceIndex);
        _singleAlbumService.albumsData
            .insert(replaceIndex, SingleAlbumData(data: curr));
      }
    }
  }

  /// Sorts the [SingleAlbumRepository] by the start date of each album.
  void sortByDates() {
    _singleAlbumService.albumsData.sort(
      (a, b) => b.data.dates.start.compareTo(a.data.dates.start),
    );
  }

  /// Sorts the [SingleAlbumRepository] by the title of each album.
  void sortByName() {
    _singleAlbumService.albumsData.sort(
      (a, b) => a.data.title.compareTo(b.data.title),
    );
  }

  /// Sorts the [SingleAlbumRepository] by the [lastModified] property of each
  /// album.
  void sortByLastModified() {
    _singleAlbumService.albumsData.sort(
      (a, b) => b.data.lastModified.compareTo(a.data.lastModified),
    );
  }
}
