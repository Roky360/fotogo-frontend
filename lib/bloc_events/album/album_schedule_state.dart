part of 'album_schedule_bloc.dart';

@immutable
abstract class AlbumScheduleState {
  const AlbumScheduleState();
}

class AlbumScheduleInitial extends AlbumScheduleState {}

class AlbumScheduleCreating extends AlbumScheduleState {
  final AlbumScheduleData albumScheduleData;

  const AlbumScheduleCreating(this.albumScheduleData);
}

class AlbumScheduleCreated extends AlbumScheduleState {
  final String message; // change to "message"

  const AlbumScheduleCreated(this.message);
  // TODO: == operator
}

class AlbumScheduleError extends AlbumScheduleState {
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
