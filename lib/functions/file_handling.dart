import 'dart:io';
import 'dart:typed_data';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List> readFileBytes(String path) async {
  final File file = File(path);
  final bytes = await file.readAsBytes();
  return bytes;
}

Future<Uint8List> readAssetBytes(String path) async {
  final data = await rootBundle.load(path);
  return data.buffer.asUint8List();
}

Future<File> writeToFile(Uint8List data, String path) {
  return File(path).writeAsBytes(data);
}

Future<File> writeFileToTempDirectory(Uint8List data, String fileName) async {
  final tempPath = (await getTemporaryDirectory()).path;
  return writeToFile(data, "$tempPath/$fileName");
}

/// Calculates the date range of a list of [File]s (typically images).
///
/// Using [readExifFromFile] to read its [DateTime] timestamp, if exists. If
/// none of the images has metadata, returns the date of today.
Future<DateTimeRange> calculateDateRangeFromImages(List<File> images) async {
  final List<DateTime> imagesDates = [];
  // generate a list of all the timestamps of the images, if exists.
  for (final i in images) {
    final exifData = await readExifFromFile(i);
    if (exifData.isNotEmpty && exifData.containsKey("Image DateTime")) {
      imagesDates.add(DateTime.parse(exifData['Image DateTime']!
          .printable
          .split(' ')[0]
          .replaceAll(':', '-')));
    }
  }

  // if none of the images has a date, return the date of today.
  if (imagesDates.isEmpty) {
    return DateTimeRange(start: DateTime.now(), end: DateTime.now());
  }

  DateTime lowerBound = DateTime.now();
  DateTime upperBound = imagesDates[0];

  for (final i in imagesDates) {
    if (i.isBefore(lowerBound)) lowerBound = i;
    if (i.isAfter(upperBound)) upperBound = i;
  }

  return DateTimeRange(start: lowerBound, end: upperBound);
}

/// Opens an interactive native image picker.
Future pickImage() async {
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image == null) return;

  return File(image.path);
}
