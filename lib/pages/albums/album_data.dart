import 'package:flutter/material.dart';

class AlbumData {
  AlbumData({
    required this.title,
    required this.dates,
    required this.isShared,
    required this.tags,
  });

  final String title;
  final DateTimeRange dates;
  final bool isShared;
  final List<String> tags;
  // image list
}
