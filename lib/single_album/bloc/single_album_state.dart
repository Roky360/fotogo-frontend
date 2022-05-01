part of 'single_album_bloc.dart';

@immutable
abstract class SingleAlbumState {
  const SingleAlbumState();
}

class SingleAlbumInitial extends SingleAlbumState {
  const SingleAlbumInitial();
}

class SingleAlbumFetched extends SingleAlbumState {
  const SingleAlbumFetched();
}

class SingleAlbumDeleted extends SingleAlbumState {
  const SingleAlbumDeleted();
}

class SingleAlbumError extends SingleAlbumState {
  final String message;

  const SingleAlbumError(this.message);
}
