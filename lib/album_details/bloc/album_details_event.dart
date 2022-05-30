part of 'album_details_bloc.dart';

@immutable
abstract class AlbumDetailsEvent {
  const AlbumDetailsEvent();
}

/// Register to  the [dataStreamController] of [Client].
///
/// This event is called only once - when the bloc is created.
class AlbumDetailsRegisterDataStreamEvent extends AlbumDetailsEvent {
  const AlbumDetailsRegisterDataStreamEvent();
}

/// Syncs the albums at client side with the albums in the DB.
class SyncAlbumsDetailsEvent extends AlbumDetailsEvent {
  const SyncAlbumsDetailsEvent();
}

class SyncedAlbumsDetailsEvent extends AlbumDetailsEvent {
  final Response response;

  const SyncedAlbumsDetailsEvent(this.response);
}
