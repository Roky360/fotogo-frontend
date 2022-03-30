import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

Future<Uint8List> readFileBytes(String path) async {
  final File file = File(path);
  final bytes = await file.readAsBytes();
  return bytes;
}

Future<Uint8List> readAssetBytes(String path) async {
  final data = await rootBundle.load(path);
  return data.buffer.asUint8List();
}
