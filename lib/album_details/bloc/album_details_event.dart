part of 'album_details_bloc.dart';

@immutable
abstract class AlbumDetailsEvent {
  const AlbumDetailsEvent();
}

class AlbumDetailsRegisterDataStreamEvent extends AlbumDetailsEvent {
  const AlbumDetailsRegisterDataStreamEvent();
}

class GetAlbumsDetailsEvent extends AlbumDetailsEvent {
  const GetAlbumsDetailsEvent();
}

class GotAlbumsDetailsEvent extends AlbumDetailsEvent {
  final Response response;

  const GotAlbumsDetailsEvent(this.response);
}
