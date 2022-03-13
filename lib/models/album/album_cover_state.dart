part of 'album_bloc.dart';

// loading state
class AlbumCoverInitial extends AlbumState {}

class AlbumCoverFetched extends AlbumState {
  final List<AlbumData> albumData;

  const AlbumCoverFetched(this.albumData);
}

class AlbumCoverError extends AlbumState {
  final String message;

  const AlbumCoverError(this.message);
}
