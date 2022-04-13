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
  AlbumDetailsSender.getAlbumDetails(Request request)
      : super(RequestType.getAlbumDetails, request);
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

// enum Sender {
//   auth,
//   albumCreation,
//   albumDetails,
//   single_album,
// }
//
// extension SubSender on Sender {
//   // auth
//   int get auth => 0;
//
//   int get checkUserExists => 1;
//
//   int get createAccount => 2;
//
//   int get deleteAccount => 3;
//
//   // albumCreation
//   int get createAlbum => 4;
//
//   // albumDetails
//   int get getAlbumContents => 6;
//
//   // single_album
//   int get getAlbumDetails => 5;
//
//   int get updateAlbum => 7;
//
//   int get addImagesToAlbum => 8;
//
//   int get removeImagesFromAlbum => 9;
//
//   int get deleteAlbum => 10;
//
//   //
//   int get uploadImage => 11;
//
//   int get deleteImage => 12;
// }
