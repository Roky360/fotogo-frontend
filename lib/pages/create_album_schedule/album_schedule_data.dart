import 'package:flutter/material.dart';

class AlbumScheduleData {
  AlbumScheduleData(
      {required this.title, required this.dates, required this.sharedPeople});

  final String title;
  final DateTimeRange dates;
  final List<String> sharedPeople;
}
