import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/pages/albums/album_data.dart';
import 'package:fotogo/pages/create_album/album_creation_data.dart';
import 'package:fotogo/services/albums_service.dart';
import 'package:meta/meta.dart';

import '../../pages/create_album_schedule/album_schedule_data.dart';

part 'album_event.dart';

part 'album_schedule_state.dart';

part 'album_cover_state.dart';

part 'album_state.dart';

part 'album_creation_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumService _albumsService;

  AlbumBloc(this._albumsService) : super(AlbumInitial()) {
    on<CreateAlbumScheduleEvent>((event, emit) async {
      try {
        emit(AlbumScheduleCreating(event.albumScheduleData));
        final response =
            await _albumsService.createAlbumSchedule(event.albumScheduleData);
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

    on<CreateAlbumEvent>((event, emit) async {
      void callback(Response response) {
        switch (response.statusCode) {
          case StatusCode.created_201:
            emit(AlbumCreationCreated(response));
            break;
          case StatusCode.badRequest_400:
            emit(const AlbumCreationError('Bad request'));
            break;
          case StatusCode.unauthorized_401:
            emit(const AlbumCreationError('Unauthorized'));
            break;
          case StatusCode.internalServerError_500:
            emit(const AlbumCreationError('Internal server error.'));
            break;
          default:
            break;
        }
      }

      try {
        emit(const AlbumCreationCreating());
        await _albumsService.createAlbum(
            event.albumCreationData, callback);
      } catch (e) {
        rethrow;
      }
    });
  }
}
