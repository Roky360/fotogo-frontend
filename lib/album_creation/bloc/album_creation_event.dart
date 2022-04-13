part of 'album_creation_bloc.dart';

@immutable
abstract class AlbumCreationEvent {
  const AlbumCreationEvent();
}

class AlbumCreationRegisterDataStreamEvent extends AlbumCreationEvent {
  const AlbumCreationRegisterDataStreamEvent();
}

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

  const CreatedAlbumEvent(this.response);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreatedAlbumEvent &&
          runtimeType == other.runtimeType &&
          response == other.response;

  @override
  int get hashCode => response.hashCode;
}
