part of 'album_bloc.dart';

@immutable
abstract class AlbumEvent {
  const AlbumEvent();
}

class CreateAlbumScheduleEvent extends AlbumEvent {
  final AlbumScheduleData albumScheduleData;

  const CreateAlbumScheduleEvent(this.albumScheduleData);
}

// get details for album covers in the albums page
class FetchAlbumsDetailsEvent extends AlbumEvent {
  final Function callback;

  const FetchAlbumsDetailsEvent({required this.callback});
}

class CreateAlbumEvent extends AlbumEvent {
  final AlbumCreationData albumCreationData;

  const CreateAlbumEvent({required this.albumCreationData});
}
