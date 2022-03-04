import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fotogo/pages/create_album/album_schedule_data.dart';
import 'package:fotogo/services/albums_service.dart';
import 'package:meta/meta.dart';

part 'album_schedule_event.dart';

part 'album_schedule_state.dart';

class AlbumScheduleBloc extends Bloc<AlbumScheduleEvent, AlbumScheduleState> {
  final AlbumsService _albumsService;

  AlbumScheduleBloc(this._albumsService) : super(AlbumScheduleInitial()) {
    on<CreateAlbumSchedule>((event, emit) async {
      try {
        emit(AlbumScheduleCreating(event.albumScheduleData));
        final response =
            await _albumsService.createAlbum(event.albumScheduleData);
        emit(AlbumScheduleCreated(response));
        // if (!status) {
        //   emit(const AlbumScheduleError(
        //       'Something went wrong on the server side. Please try again later.'));
        // }
      } on WebSocketException {
        // TODO: catch all exceptions that create_album() can throw
        emit(const AlbumScheduleError(
            'There was a network error. Check your internet connection.'));
      }
    });
  }
}
