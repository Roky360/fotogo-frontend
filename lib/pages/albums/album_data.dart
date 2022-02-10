import 'package:flutter/material.dart';

class AlbumData {
  final String title;
  final DateTimeRange dates;
  final bool isShared;
  // image list

  AlbumData({
    required this.title,
    required this.dates,
    required this.isShared,
});
}