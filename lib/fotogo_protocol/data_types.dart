import 'package:flutter/cupertino.dart';

enum RequestType {
  auth,
  checkUserExists,
  createAccount,
  deleteAccount,
  createAlbum,
  getAlbumDetails,
  getAlbumContents,
  updateAlbum,
  addImagesToAlbum,
  removeImagesFromAlbum,
  deleteAlbum,
  uploadImage,
  deleteImage
}

class StatusCode {
  static int get ok => 200;

  static int get created => 201;

  static int get badRequest => 400;

  static int get unauthorized => 401;

  static int get forbidden => 403;

  static int get notFound => 404;

  static int get internalServerError => 500;
}

class Request {
  final RequestType requestType;
  final String? idToken;
  late final Map<String, Object> args;
  late final List payload;

  Request({
    required this.requestType,
    required this.idToken,
    Map<String, Object>? args,
    List? payload,
  }) {
    this.args = args ?? {};
    this.payload = payload ?? [];
  }
}

class Response {
  final int statusCode;

  final dynamic payload;

  Response({required this.statusCode, required this.payload});

  @override
  String toString() {
    return "Response(status_code: $statusCode, payload: $payload)";
  }
}

class ImageData {
  final String fileName;
  final DateTime? timestamp;

  // final Geolocation location;
  final List<String> containingAlbums;
  final int? tag;
  final MemoryImage data;

  ImageData(
      {required this.fileName,
      this.timestamp,
      // required this.location,
      required this.containingAlbums,
      this.tag,
      required this.data});
}
