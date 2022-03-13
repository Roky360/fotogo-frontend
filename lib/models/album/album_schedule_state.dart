part of 'album_bloc.dart';

class AlbumScheduleInitial extends AlbumState {}

class AlbumScheduleCreating extends AlbumState {
  final AlbumScheduleData albumScheduleData;

  const AlbumScheduleCreating(this.albumScheduleData);
}

class AlbumScheduleCreated extends AlbumState {
  final String message; // change to "message"

  const AlbumScheduleCreated(this.message);
// TODO: == operator
}

class AlbumScheduleError extends AlbumState {
  final String message;

  const AlbumScheduleError(this.message);
// TODO: == operator
}


/// States:
/// -------
/// Album schedule:
/// * Creation
///   - Initial
///   - loading
///   - loaded
///   - error
/// * Get album:
///   - initial (?)
///   - loading
///   - loaded
///   - error
/// * Get album list:
///   - initial (?)
///   - loading
///   - loaded
///   - error
