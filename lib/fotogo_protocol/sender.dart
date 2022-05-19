import 'data_types.dart';

abstract class Sender {
  final RequestType requestType;
  final Request request;
  late final Response response;

  Sender(this.requestType, this.request);
}

class AuthSender extends Sender {
  AuthSender.auth(Request request) : super(RequestType.auth, request);

  AuthSender.checkUserExists(Request request)
      : super(RequestType.checkUserExists, request);

  AuthSender.createAccount(Request request)
      : super(RequestType.createAccount, request);

  AuthSender.deleteAccount(Request request)
      : super(RequestType.deleteAccount, request);
}

class AlbumCreationSender extends Sender {
  AlbumCreationSender.createAlbum(Request request)
      : super(RequestType.createAlbum, request);
}

class AlbumDetailsSender extends Sender {
  AlbumDetailsSender.syncAlbumDetails(Request request)
      : super(RequestType.syncAlbumDetails, request);
}

class AlbumSender extends Sender {
  AlbumSender.getAlbumContents(Request request)
      : super(RequestType.getAlbumContents, request);

  AlbumSender.updateAlbum(Request request)
      : super(RequestType.updateAlbum, request);

  AlbumSender.addImagesToAlbum(Request request)
      : super(RequestType.addImagesToAlbum, request);

  AlbumSender.removeImagesFromAlbum(Request request)
      : super(RequestType.removeImagesFromAlbum, request);

  AlbumSender.deleteAlbum(Request request)
      : super(RequestType.deleteAlbum, request);
}
