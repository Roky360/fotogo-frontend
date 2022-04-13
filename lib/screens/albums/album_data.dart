import 'package:flutter/material.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';

class AlbumData {
  final String id;
  final String title;
  final DateTimeRange dates;
  final bool isShared;
  final List tags;
  // final String coverImage;
  late List<ImageData> images;

  AlbumData({
    required this.id,
    required this.title,
    required this.dates,
    required this.isShared,
    required this.tags,
    // required this.coverImage,
    List<ImageData>? images,
  }) {
    this.images = images ?? List.empty(growable: true);
  }
}
