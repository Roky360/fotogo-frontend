import 'data_types.dart';

/// Holds a record of the request process to the server.
///
/// Holds both the [Request] that the client has built and the [Response] that
/// came from the server, as well as the [RequestType].
abstract class Sender {
  final RequestType requestType;
  final Request request;
  late final Response response;

  Sender(this.requestType, this.request);
}

/// A [Sender] that related to auth requests.
///
/// Used by [AuthBloc].
class AuthSender extends Sender {
  AuthSender.auth(Request request) : super(RequestType.auth, request);

  AuthSender.checkUserExists(Request request)
      : super(RequestType.checkUserExists, request);

  AuthSender.createAccount(Request request)
      : super(RequestType.createAccount, request);

  AuthSender.deleteAccount(Request request)
      : super(RequestType.deleteAccount, request);
}

/// A [Sender] that related to album creation requests.
///
/// Used by [AlbumCreationBloc] and [AlbumDetailsBloc].
class AlbumCreationSender extends Sender {
  AlbumCreationSender.createAlbum(Request request)
      : super(RequestType.createAlbum, request);
}

class AlbumDetailsSender extends Sender {
  AlbumDetailsSender.syncAlbumDetails(Request request)
      : super(RequestType.syncAlbumDetails, request);
}

/// A [Sender] that related to album requests.
///
/// Used by [SingleAlbumBloc].
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

  AlbumSender.extDeleteAlbum(Request request)
      : super(RequestType.extDeleteAlbum, request);

  AlbumSender.extAddImagesTpAlbum(Request request)
      : super(RequestType.extAddImagesToAlbum, request);
}
