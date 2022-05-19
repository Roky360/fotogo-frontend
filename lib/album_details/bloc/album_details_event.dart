part of 'album_details_bloc.dart';

@immutable
abstract class AlbumDetailsEvent {
  const AlbumDetailsEvent();
}

class AlbumDetailsRegisterDataStreamEvent extends AlbumDetailsEvent {
  const AlbumDetailsRegisterDataStreamEvent();
}

class SyncAlbumsDetailsEvent extends AlbumDetailsEvent {
  const SyncAlbumsDetailsEvent();
}

class SyncedAlbumsDetailsEvent extends AlbumDetailsEvent {
  final Response response;

  const SyncedAlbumsDetailsEvent(this.response);
}
