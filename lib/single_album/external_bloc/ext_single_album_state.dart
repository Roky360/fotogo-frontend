part of 'ext_single_album_bloc.dart';

@immutable
abstract class ExtSingleAlbumState {
  const ExtSingleAlbumState();
}

class ExtSingleAlbumInitial extends ExtSingleAlbumState {
  const ExtSingleAlbumInitial();
}

class ExtUpdatedAlbum extends ExtSingleAlbumState {
  const ExtUpdatedAlbum();
}

class ExtSingleAlbumDeleted extends ExtSingleAlbumState {
  final int deletedIndex;

  const ExtSingleAlbumDeleted(this.deletedIndex);
}

class ExtSingleAlbumMessage extends ExtSingleAlbumState {
  final String message;
  final FotogoSnackBarIcon icon;

  const ExtSingleAlbumMessage(this.message, this.icon);
}
