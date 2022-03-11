import 'package:flutter/material.dart';

class AlbumData {
  final String title;
  final DateTimeRange dates;
  final bool isShared;
  final List<String> tags;
  final String coverImagePath;
  // image list

  AlbumData({
    required this.title,
    required this.dates,
    required this.isShared,
    required this.tags,
    required this.coverImagePath
  });
}
