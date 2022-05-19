import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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
