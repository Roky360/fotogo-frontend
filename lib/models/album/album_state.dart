part of 'album_bloc.dart';

@immutable
abstract class AlbumState {
  const AlbumState();
}

class AlbumInitial extends AlbumState {}

class AlbumFetched extends AlbumState {
  final List<Image> fetchedImages;

  const AlbumFetched(this.fetchedImages);
}

class AlbumLoading extends AlbumState {}
