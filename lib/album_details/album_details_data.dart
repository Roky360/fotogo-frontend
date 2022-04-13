import 'package:flutter/material.dart' show DateTimeRange;

class AlbumDetailsData {
  final String id;
  final String title;
  final DateTimeRange dates;
  final List<String> permittedUsers;

  // TODO: url or whole image file?
  final String coverImage;
  final DateTime lastModified;

  AlbumDetailsData(
      {required this.id,
      required this.title,
      required this.dates,
      required this.permittedUsers,
      required this.coverImage,
      required this.lastModified});
}
