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
  final String albumId;

  const GotAlbumContentsEvent(this.response, this.albumId);
}

class UpdateAlbumEvent extends SingleAlbumEvent {
  final SingleAlbumData albumData;

  const UpdateAlbumEvent(this.albumData);
}

class UpdatedAlbumEvent extends SingleAlbumEvent {
  final Response response;
  final Request request;

  const UpdatedAlbumEvent(this.response, this.request);
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
  final Request request;

  const DeletedAlbumEvent(this.response, this.request);
}
