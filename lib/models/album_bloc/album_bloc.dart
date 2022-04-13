// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fotogo/fotogo_protocol/data_types.dart';
// import 'package:fotogo/fotogo_protocol/client.dart';
// import 'package:fotogo/screens/albums/album_data.dart';
// import 'package:fotogo/album_creation/album_creation_data.dart';
// import 'package:fotogo/album/album_service.dart';
//
// import '../../screens/create_album_schedule/album_schedule_data.dart';
//
// part 'album_event.dart';
//
// part 'album_schedule_state.dart';
//
// part 'album_cover_state.dart';
//
// part 'album_state.dart';
//
// part 'album_creation_state.dart';
//
// class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
//   late final AlbumService _albumsService;
//
//   AlbumBloc(this._albumsService) : super(AlbumInitial()) {
//     on<CreateAlbumScheduleEvent>((event, emit) async {
//       try {
//         emit(AlbumScheduleCreating(event.albumScheduleData));
//         _albumsService.createAlbumSchedule(
//             event.context, event.albumScheduleData);
//       } on WebSocketException {
//         // TODO: catch all exceptions that create_album() can throw
//         emit(const AlbumScheduleError(
//             'There was a network error. Check your internet connection.'));
//       }
//     });
//
//     on<GetAlbumsDetailsEvent>((event, emit) async {
//       try {
//         final albumData = await _albumsService.getAlbumsDetails(event.context);
//         emit(AlbumCoverFetched(albumData));
//       } catch (e) {
//         emit(AlbumCoverError(e.toString()));
//       }
//     });
//
//     on<CreateAlbumEvent>((event, emit) async {
//       try {
//         emit(AlbumCreationCreating(event.albumCreationData));
//         final String newAlbumId = await _albumsService.createAlbum(
//             event.context, event.albumCreationData);
//         emit(AlbumCreationCreated(newAlbumId, event.albumCreationData));
//       } catch (e) {
//         emit(AlbumCreationError(e.toString()));
//       }
//     });
//
//     on<GetAlbumContentsEvent>((event, emit) async {
//       try {
//         final List<ImageData> images =
//         await _albumsService.getAlbumContents(event.context, event.albumId);
//
//         emit(AlbumFetched(images));
//       } catch (e) {
//         rethrow;
//         emit(AlbumError(e.toString()));
//       }
//
//     });
//   }
// }
