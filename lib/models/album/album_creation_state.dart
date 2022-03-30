part of 'album_bloc.dart';

class AlbumCreationInitial extends AlbumState {
  const AlbumCreationInitial();
}

class AlbumCreationCreating extends AlbumState {
  const AlbumCreationCreating();
}

class AlbumCreationCreated extends AlbumState {
  final Response response;

  const AlbumCreationCreated(this.response);
}

class AlbumCreationError extends AlbumState {
  final String message;

  const AlbumCreationError(this.message);
}
