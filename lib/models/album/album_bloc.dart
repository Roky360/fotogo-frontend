import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:fotogo/pages/albums/album_data.dart';
import 'package:fotogo/pages/create_album/album_schedule_data.dart';
import 'package:fotogo/services/albums_service.dart';
import 'package:meta/meta.dart';

part 'album_event.dart';

part 'album_schedule_state.dart';

part 'album_cover_state.dart';

part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumService _albumsService;

  AlbumBloc(this._albumsService) : super(AlbumInitial()) {
    on<CreateAlbumScheduleEvent>((event, emit) async {
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
    on<FetchAlbumsDetailsEvent>((event, emit) async {
      try {
        final response = await _albumsService.fetchAlbumsDetails();
        emit(AlbumCoverFetched(response));
      } catch (e) {
        emit(AlbumCoverError(e.toString()));
      }
    });
  }
}
