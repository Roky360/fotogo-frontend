import 'dart:typed_data';

enum RequestType {
  auth,
  checkUserExists,
  createAccount,
  deleteAccount,
  createAlbum,
  syncAlbumDetails,
  getAlbumContents,
  updateAlbum,
  addImagesToAlbum,
  removeImagesFromAlbum,
  deleteAlbum,
  uploadImage,
  deleteImage
}

class StatusCode {
  static const int ok = 200;

  static const int created = 201;

  static const int badRequest = 400;

  static const int unauthorized = 401;

  static const int forbidden = 403;

  static const int notFound = 404;

  static const int internalServerError = 500;
}

class PrivilegeLevel {
  static const int unregistered = -1;
  static const int admin = 0;
  static const int user = 1;
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
  final Uint8List data;

  ImageData(
      {required this.fileName,
      this.timestamp,
      // required this.location,
      required this.containingAlbums,
      this.tag,
      required this.data});
}
