// part of 'album_bloc.dart';
//
// @immutable
// abstract class AlbumState {
//   const AlbumState();
// }
//
// class AlbumInitial extends AlbumState {}
//
// class AlbumFetched extends AlbumState {
//   final List<ImageData> fetchedImages;
//
//   const AlbumFetched(this.fetchedImages);
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is AlbumFetched &&
//           runtimeType == other.runtimeType &&
//           fetchedImages == other.fetchedImages;
//
//   @override
//   int get hashCode => fetchedImages.hashCode;
// }
//
// class AlbumError extends AlbumState {
//   final String message;
//
//   const AlbumError(this.message);
// }
