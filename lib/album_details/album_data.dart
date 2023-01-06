import 'dart:typed_data';

import 'package:flutter/material.dart' show DateTimeRange;

/// Holds information about an album.
///
/// Contains its id, title, date range, permitted users, cover image and
/// last-modified timestamp.
class AlbumData {
  final String id;
  String title;
  DateTimeRange dates;
  List<String> permittedUsers;

  // TODO: url or whole image file?
  final String coverImage;

  // final Uint8List coverImage;
  DateTime lastModified;

  AlbumData(
      {required this.id,
      required this.title,
      required this.dates,
      required this.permittedUsers,
      required this.coverImage,
      required this.lastModified});

  AlbumData copyWith(
      {String? id,
      String? title,
      DateTimeRange? dates,
      List<String>? permittedUsers,
      String? coverImage,
      DateTime? lastModified}) {
    return AlbumData(
        id: id ?? this.id,
        title: title ?? this.title,
        dates: dates ?? this.dates,
        coverImage: coverImage ?? this.coverImage,
        lastModified: lastModified ?? this.lastModified,
        permittedUsers: permittedUsers ?? this.permittedUsers);
  }
}
