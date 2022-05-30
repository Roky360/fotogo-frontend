part of 'album_creation_bloc.dart';

@immutable
abstract class AlbumCreationState {
  const AlbumCreationState();
}

/// Initial state of the [CreateAlbumPage].
class AlbumCreationInitial extends AlbumCreationState {
  const AlbumCreationInitial();
}

/// A request to create an album has been sent to the server, waiting for
/// response.
class AlbumCreating extends AlbumCreationState {
  final AlbumCreationData albumCreationData;

  const AlbumCreating(this.albumCreationData);
}

/// Album has been created.
class AlbumCreated extends AlbumCreationState {
  const AlbumCreated();
}

/// Display a message related to [AlbumCreationBloc].
class AlbumCreationMessage extends AlbumCreationState {
  final String message;
  final FotogoSnackBarIcon icon;

  const AlbumCreationMessage(this.message, this.icon);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumCreationMessage &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
