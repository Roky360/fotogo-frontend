// part of 'album_bloc.dart';
//
// class AlbumScheduleInitial extends AlbumState {}
//
// class AlbumScheduleCreating extends AlbumState {
//   final AlbumScheduleData albumScheduleData;
//
//   const AlbumScheduleCreating(this.albumScheduleData);
// }
//
// class AlbumScheduleCreated extends AlbumState {
//   final String message; // change to "message"
//
//   const AlbumScheduleCreated(this.message);
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is AlbumScheduleCreated &&
//           runtimeType == other.runtimeType &&
//           message == other.message;
//
//   @override
//   int get hashCode => message.hashCode;
// }
//
// class AlbumScheduleError extends AlbumState {
//   final String message;
//
//   const AlbumScheduleError(this.message);
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is AlbumScheduleError &&
//           runtimeType == other.runtimeType &&
//           message == other.message;
//
//   @override
//   int get hashCode => message.hashCode;
// }
//
//
// /// States:
// /// -------
// /// Album schedule:
// /// * Creation
// ///   - Initial
// ///   - loading
// ///   - loaded
// ///   - error
// /// * Get album_bloc:
// ///   - initial (?)
// ///   - loading
// ///   - loaded
// ///   - error
// /// * Get album_bloc list:
// ///   - initial (?)
// ///   - loading
// ///   - loaded
// ///   - error
