part of 'album_details_bloc.dart';

@immutable
abstract class AlbumDetailsState {
  const AlbumDetailsState();
}

class AlbumDetailsInitial extends AlbumDetailsState {
  const AlbumDetailsInitial();
}

class AlbumDetailsFetched extends AlbumDetailsState {
  const AlbumDetailsFetched();
}

class AlbumDetailsError extends AlbumDetailsState {
  final String message;

  const AlbumDetailsError(this.message);
}
