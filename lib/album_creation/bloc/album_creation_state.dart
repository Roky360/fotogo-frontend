part of 'album_creation_bloc.dart';

@immutable
abstract class AlbumCreationState {
  const AlbumCreationState();
}

class AlbumCreationInitial extends AlbumCreationState {
  const AlbumCreationInitial();
}

class AlbumCreating extends AlbumCreationState {
  final AlbumCreationData albumCreationData;

  const AlbumCreating(this.albumCreationData);
}

class AlbumCreated extends AlbumCreationState {
  const AlbumCreated();
}

class AlbumCreationError extends AlbumCreationState {
  final String message;

  const AlbumCreationError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumCreationError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
