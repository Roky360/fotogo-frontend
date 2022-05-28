import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_details/album_details_service.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:fotogo/single_album/single_album_service.dart';

part 'album_details_event.dart';

part 'album_details_state.dart';

class AlbumDetailsBloc extends Bloc<AlbumDetailsEvent, AlbumDetailsState> {
  final AlbumDetailsService _albumDetailsService = AlbumDetailsService();
  final SingleAlbumService _singleAlbumService = SingleAlbumService();
  final ClientService _clientService = ClientService();

  bool registeredDataListener = false;
  late final StreamSubscription dataStreamSubscription;

  AlbumDetailsBloc() : super(const AlbumDetailsInitial()) {
    on<AlbumDetailsRegisterDataStreamEvent>((event, emit) {
      if (registeredDataListener) return;

      dataStreamSubscription =
          _clientService.registerToDataStreamController((event) {
        if (event is! AlbumDetailsSender) return;

        switch (event.requestType) {
          case RequestType.syncAlbumDetails:
            add(SyncedAlbumsDetailsEvent(event.response));
            break;
          default:
            break;
        }
      });

      registeredDataListener = true;
    });
    add(const AlbumDetailsRegisterDataStreamEvent());

    on<SyncAlbumsDetailsEvent>((event, emit) {
      try {
        _albumDetailsService.syncAlbumsDetails({
          for (var element in _singleAlbumService.albumsData)
            element.data.id: element.data.lastModified.toString()
        });
      } catch (e) {
        emit(AlbumDetailsError(e.toString()));
      }
    });
    on<SyncedAlbumsDetailsEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        _albumDetailsService.updateAlbumDetailsByResponse(event.response);
        _singleAlbumService.deleteDuplicates();

        emit(const AlbumDetailsInitial());
        emit(const AlbumDetailsFetched());
      } else {
        emit(AlbumDetailsError(event.response.payload));
      }
    });
  }

  @override
  Future<void> close() {
    dataStreamSubscription.cancel();

    return super.close();
  }
}
