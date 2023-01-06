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

class AlbumUpdated extends SingleAlbumState {
  const AlbumUpdated();
}

class SingleAlbumDeleted extends SingleAlbumState {
  final int deletedIndex;

  const SingleAlbumDeleted(this.deletedIndex);
}

class SingleAlbumMessage extends SingleAlbumState {
  final String message;
  final FotogoSnackBarIcon icon;
  final Exception? exception;

  const SingleAlbumMessage(this.message, this.icon, {this.exception});
}
