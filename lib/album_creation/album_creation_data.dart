import 'dart:io';

import 'package:flutter/material.dart';

/// Holds all needed data to send a request to create a new album.
class AlbumCreationData {
  final String title;
  final DateTimeRange dateRange;
  final List<String> sharedPeople;
  final List<File> imagesFiles;
  final DateTime creationTime;

  AlbumCreationData({
    required this.title,
    required this.dateRange,
    required this.sharedPeople,
    required this.imagesFiles,
    required this.creationTime
  });
}
