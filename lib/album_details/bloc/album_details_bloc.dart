import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fotogo/album_details/album_details_service.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:meta/meta.dart';

import '../album_details_data.dart';

part 'album_details_event.dart';

part 'album_details_state.dart';

class AlbumDetailsBloc extends Bloc<AlbumDetailsEvent, AlbumDetailsState> {
  final AlbumDetailsService _albumDetailsService = AlbumDetailsService();
  final ClientService _clientService = ClientService();

  bool registeredDataListener = false;

  AlbumDetailsBloc() : super(const AlbumDetailsInitial()) {
    on<AlbumDetailsRegisterDataStreamEvent>((event, emit) {
      if (registeredDataListener) return;

      _clientService.registerToDataStreamController((event) {
        if (event is! AlbumDetailsSender) return;

        switch (event.requestType) {
          case RequestType.getAlbumDetails:
            add(GotAlbumsDetailsEvent(event.response));
            break;
          default:
            break;
        }
      });

      registeredDataListener = true;
    });
    add(const AlbumDetailsRegisterDataStreamEvent());

    on<GetAlbumsDetailsEvent>((event, emit) {
      try {
        _albumDetailsService.getAlbumsDetails({
          for (var element in _albumDetailsService.albumsDetailsData)
            element.id: element.lastModified.toString()
        });
      } catch (e) {
        emit(AlbumDetailsError(e.toString()));
      }
    });
    on<GotAlbumsDetailsEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        _albumDetailsService.updateAlbumDetailsByResponse(event.response);

        emit(const AlbumDetailsFetched());
      } else {
        emit(AlbumDetailsError(event.response.payload));
      }
    });
  }
}
