import 'dart:typed_data';

import 'package:flutter/material.dart' show DateTimeRange;

class AlbumData {
  final String id;
  final String title;
  final DateTimeRange dates;
  final List<String> permittedUsers;

  // TODO: url or whole image file?
  final Uint8List coverImage;
  final DateTime lastModified;

  AlbumData(
      {required this.id,
      required this.title,
      required this.dates,
      required this.permittedUsers,
      required this.coverImage,
      required this.lastModified});
}
