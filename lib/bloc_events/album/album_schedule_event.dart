part of 'album_schedule_bloc.dart';

@immutable
abstract class AlbumScheduleEvent {}

class CreateAlbumSchedule extends AlbumScheduleEvent {
  final AlbumScheduleData albumScheduleData;

  CreateAlbumSchedule(this.albumScheduleData);
}
