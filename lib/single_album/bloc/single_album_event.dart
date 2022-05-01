part of 'single_album_bloc.dart';

@immutable
abstract class SingleAlbumEvent {
  const SingleAlbumEvent();
}

class SingleAlbumRegisterDataStreamEvent extends SingleAlbumEvent {
  const SingleAlbumRegisterDataStreamEvent();
}

class GetAlbumContentsEvent extends SingleAlbumEvent {
  final String albumId;

  const GetAlbumContentsEvent(this.albumId);
}

class GotAlbumContentsEvent extends SingleAlbumEvent {
  final Response response;

  const GotAlbumContentsEvent(this.response);
}

class UpdateAlbumEvent extends SingleAlbumEvent {
  final String albumId;

  const UpdateAlbumEvent(this.albumId);
}

class UpdatedAlbumEvent extends SingleAlbumEvent {
  final Response response;

  const UpdatedAlbumEvent(this.response);
}

class AddImagesToAlbumEvent extends SingleAlbumEvent {
  final String albumId;
  final List<File> imagesToAdd;

  const AddImagesToAlbumEvent(this.albumId, this.imagesToAdd);
}

class AddedImagesToAlbumEvent extends SingleAlbumEvent {
  final Response response;

  const AddedImagesToAlbumEvent(this.response);
}

class RemoveImagesFromAlbumEvent extends SingleAlbumEvent {
  final String albumId;
  final List<String> imagesFileNamesToRemove;

  const RemoveImagesFromAlbumEvent(this.albumId, this.imagesFileNamesToRemove);
}

class RemovedImagesFromAlbumEvent extends SingleAlbumEvent {
  final Response response;

  const RemovedImagesFromAlbumEvent(this.response);
}

class DeleteAlbumEvent extends SingleAlbumEvent {
  final String albumId;

  const DeleteAlbumEvent(this.albumId);
}

class DeletedAlbumEvent extends SingleAlbumEvent {
  final Response response;
  final String deletedAlbumId;

  const DeletedAlbumEvent(this.response, this.deletedAlbumId);
}
