import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_creation/album_creation_data.dart';
import 'package:fotogo/album_creation/album_creation_service.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:fotogo/widgets/app_widgets.dart';

part 'album_creation_event.dart';

part 'album_creation_state.dart';

/// Handles the [CreateAlbumPage].
class AlbumCreationBloc extends Bloc<AlbumCreationEvent, AlbumCreationState> {
  final AlbumCreationService _albumCreationService = AlbumCreationService();
  final SingleAlbumService _singleAlbumService = SingleAlbumService();
  final ClientService _clientService = ClientService();

  bool registeredDataListener = false;
  late final StreamSubscription dataStreamSubscription;

  AlbumCreationBloc() : super(const AlbumCreationInitial()) {
    on<AlbumCreationRegisterDataStreamEvent>((event, emit) {
      if (registeredDataListener) return;

      dataStreamSubscription =
          _clientService.registerToDataStreamController((event) {
        if (event is! AlbumCreationSender) return;

        switch (event.requestType) {
          case RequestType.createAlbum:
            add(CreatedAlbumEvent(event.response, event.request));
            break;
          default:
            break;
        }
      });

      registeredDataListener = true;
    });
    add(const AlbumCreationRegisterDataStreamEvent());

    on<CreateAlbumEvent>((event, emit) {
      emit(AlbumCreating(event._albumCreationData));

      try {
        _albumCreationService.createAlbum(event._albumCreationData);
      } catch (e) {
        errorHandler(emit, e as Exception);
      }
    });
    on<CreatedAlbumEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.created) {
        _albumCreationService.addCreatedAlbumToRepository(
            event.request, event.response);
        _singleAlbumService.deleteDuplicates();

        emit(AlbumCreationMessage(
            'Album "${(event.request.args['album_data'] as Map)['name']}" created',
            FotogoSnackBarIcon.success,
            bottomPadding: fSnackBarPaddingFromBNB));
        emit(const AlbumCreated());
      } else {
        errorHandler(emit, event.response.payload);
      }
    });
  }

  void errorHandler(Emitter emit, Exception e) {
    if (e is SocketException) {
      emit(AlbumCreationMessage(
          "Could not connect to server. Try checking your internet connection.",
          FotogoSnackBarIcon.error,
          exception: e));
    } else {
      emit(AlbumCreationMessage(
          "An unexpected error occurred. Sorry for the inconvenience",
          FotogoSnackBarIcon.error,
          exception: e));
    }
  }

  @override
  Future<void> close() {
    dataStreamSubscription.cancel();

    return super.close();
  }
}
