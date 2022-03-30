import 'dart:io';

import 'package:flutter/material.dart';

class AlbumCreationData {
  final String title;
  final DateTimeRange dates;
  final List<String> sharedPeople;
  final List<File> images;

  AlbumCreationData({
    required this.title,
    required this.dates,
    required this.sharedPeople,
    required this.images,
  });
}
