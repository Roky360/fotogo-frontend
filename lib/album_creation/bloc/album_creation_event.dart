part of 'album_creation_bloc.dart';

@immutable
abstract class AlbumCreationEvent {
  const AlbumCreationEvent();
}

/// Register to  the [dataStreamController] of [Client].
///
/// This event is called only once - when the bloc is created.
class AlbumCreationRegisterDataStreamEvent extends AlbumCreationEvent {
  const AlbumCreationRegisterDataStreamEvent();
}

/// An event called to create a new album.
class CreateAlbumEvent extends AlbumCreationEvent {
  final AlbumCreationData _albumCreationData;

  const CreateAlbumEvent(this._albumCreationData);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateAlbumEvent &&
          runtimeType == other.runtimeType &&
          _albumCreationData == other._albumCreationData;

  @override
  int get hashCode => _albumCreationData.hashCode;
}

class CreatedAlbumEvent extends AlbumCreationEvent {
  final Response response;
  final Request request; // for adding the new album to the AlbumRepository

  const CreatedAlbumEvent(this.response, this.request);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreatedAlbumEvent &&
          runtimeType == other.runtimeType &&
          response == other.response;

  @override
  int get hashCode => response.hashCode;
}
