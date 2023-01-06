import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_details/album_details_service.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:fotogo/widgets/app_widgets.dart';

import '../../fotogo_protocol/sender.dart';

part 'ext_single_album_event.dart';

part 'ext_single_album_state.dart';

class ExtSingleAlbumBloc
    extends Bloc<ExtSingleAlbumEvent, ExtSingleAlbumState> {
  final ClientService _clientService = ClientService();
  final SingleAlbumService _singleAlbumService = SingleAlbumService();
  final AlbumDetailsService _albumDetailsService = AlbumDetailsService();

  bool registeredDataListener = false;
  late final StreamSubscription dataStreamSubscription;

  ExtSingleAlbumBloc() : super(const ExtSingleAlbumInitial()) {
    on<ExtSingleAlbumRegisterDataStreamEvent>((event, emit) {
      if (registeredDataListener) return;

      dataStreamSubscription =
          _clientService.registerToDataStreamController((event) {
        if (event is! AlbumSender) return;

        switch (event.requestType) {
          case RequestType.extAddImagesToAlbum:
            add(ExtAddedImagesToAlbumEvent(event));
            break;
          case RequestType.extDeleteAlbum:
            add(ExtDeletedAlbumEvent(event));
            break;
          default:
            break;
        }
      });

      registeredDataListener = true;
    });
    add(const ExtSingleAlbumRegisterDataStreamEvent());

    on<ExtAddImagesToAlbumEvent>((event, emit) {
      _singleAlbumService.extAddImagesToAlbum(event.albumId, event.imagesToAdd);
    });
    on<ExtAddedImagesToAlbumEvent>((event, emit) {
      final Sender sender = event.sender;

      if (sender.response.statusCode == StatusCode.ok) {
        _singleAlbumService.updateAddedImages(
            sender.request.args['album_id'].toString(),
            sender.request.payload,
            DateTime.parse(sender.request.args['last_modified'].toString()));

        emit(const ExtUpdatedAlbum());
      } else {
        errorHandler(emit, sender.response.payload);
      }
    });

    on<ExtDeleteAlbumEvent>((event, emit) {
      _singleAlbumService.extDeleteAlbum(event.albumId);
    });
    on<ExtDeletedAlbumEvent>((event, emit) {
      final Sender sender = event.sender;

      if (sender.response.statusCode == StatusCode.ok) {
        final index = _albumDetailsService
            .deleteAlbum(sender.request.args['album_id'].toString());

        emit(const ExtSingleAlbumMessage(
            'Album deleted', FotogoSnackBarIcon.info));
        emit(ExtSingleAlbumDeleted(index));
      } else {
        errorHandler(emit, sender.response.payload);
      }
    });
  }

  void errorHandler(Emitter emit, Exception e) {
    if (e is SocketException) {
      emit(ExtSingleAlbumMessage(
          "Could not connect to server. Try checking your internet connection.",
          FotogoSnackBarIcon.error,
          exception: e));
    } else {
      emit(ExtSingleAlbumMessage(
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
