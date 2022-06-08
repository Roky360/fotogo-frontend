part of 'ext_single_album_bloc.dart';

@immutable
abstract class ExtSingleAlbumEvent {
  const ExtSingleAlbumEvent();
}

/// Register to the [_dataStreamController] of [Client].
///
/// This event is called only once - when the bloc is created.
class ExtSingleAlbumRegisterDataStreamEvent extends ExtSingleAlbumEvent {
  const ExtSingleAlbumRegisterDataStreamEvent();
}

class ExtAddImagesToAlbumEvent extends ExtSingleAlbumEvent {
  final String albumId;
  final List<File> imagesToAdd;

  const ExtAddImagesToAlbumEvent(this.albumId, this.imagesToAdd);
}

class ExtAddedImagesToAlbumEvent extends ExtSingleAlbumEvent {
  final Sender sender;

  const ExtAddedImagesToAlbumEvent(this.sender);
}

class ExtDeleteAlbumEvent extends ExtSingleAlbumEvent {
  final String albumId;

  const ExtDeleteAlbumEvent(this.albumId);
}

class ExtDeletedAlbumEvent extends ExtSingleAlbumEvent {
  final Sender sender;

  const ExtDeletedAlbumEvent(this.sender);
}
