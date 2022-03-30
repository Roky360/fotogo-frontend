import 'dart:typed_data';

enum RequestType {
  auth,
  checkUserExists,
  createAccount,
  deleteUserData,

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
  final String payload;

  Response({required this.statusCode, required this.payload});

  @override
  String toString() {
    return "Response(status_code: $statusCode, payload: $payload)";
  }
}
