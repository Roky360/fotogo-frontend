import 'dart:typed_data';

/// Holds all the supported request types between the client and the server.
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

/// Holds all the possible status codes that the server can return with a
/// [Response].
class StatusCode {
  static const int ok = 200;

  static const int created = 201;

  static const int badRequest = 400;

  static const int unauthorized = 401;

  static const int forbidden = 403;

  static const int notFound = 404;

  static const int internalServerError = 500;
}

/// Privilege levels of all kinds of users in the system.
///
/// -1 is a special [PrivilegeLevel] that means the account is [unregistered].
class PrivilegeLevel {
  static const int unregistered = -1;
  static const int admin = 0;
  static const int user = 1;
}

/// A request that is sent to the server.
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

/// A response that comes from the server.
class Response {
  final int statusCode;

  final dynamic payload;

  Response({required this.statusCode, required this.payload});

  @override
  String toString() {
    return "Response(status_code: $statusCode, payload: $payload)";
  }
}

/// Holds data about an image, as well as its bytes.
class ImageData {
  final String fileName;
  final DateTime? timestamp;

  final List<String> containingAlbums;
  final int? tag;
  // final String data;
  final Uint8List data;

  ImageData(
      {required this.fileName,
      this.timestamp,
      required this.containingAlbums,
      this.tag,
      required this.data});
}
