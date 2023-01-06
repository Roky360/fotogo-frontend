import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_details/album_details_service.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:fotogo/single_album/single_album_data.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:fotogo/widgets/app_widgets.dart';

part 'single_album_event.dart';

part 'single_album_state.dart';

/// Handles a single album, as well as [SingleAlbumPage].
class SingleAlbumBloc extends Bloc<SingleAlbumEvent, SingleAlbumState> {
  final SingleAlbumService _singleAlbumService = SingleAlbumService();
  final AlbumDetailsService _albumDetailsService = AlbumDetailsService();
  final ClientService _clientService = ClientService();

  bool registeredDataListener = false;
  late final StreamSubscription dataStreamSubscription;

  SingleAlbumBloc() : super(const SingleAlbumInitial()) {
    on<SingleAlbumRegisterDataStreamEvent>((event, emit) {
      if (registeredDataListener) return;

      dataStreamSubscription =
          _clientService.registerToDataStreamController((event) {
        if (event is! AlbumSender) return;

        switch (event.requestType) {
          case RequestType.getAlbumContents:
            add(GotAlbumContentsEvent(
                event.response, event.request.args['album_id'].toString()));
            break;
          case RequestType.updateAlbum:
            add(UpdatedAlbumEvent(event.response, event.request));
            break;
          case RequestType.addImagesToAlbum:
            add(AddedImagesToAlbumEvent(event.response, event.request));
            break;
          case RequestType.removeImagesFromAlbum:
            add(RemovedImagesFromAlbumEvent(event.response, event.request));
            break;
          case RequestType.deleteAlbum:
            add(DeletedAlbumEvent(event.response, event.request));
            break;
          default:
            break;
        }
      });

      registeredDataListener = true;
    });
    add(const SingleAlbumRegisterDataStreamEvent());

    on<GetAlbumContentsEvent>((event, emit) {
      _singleAlbumService.getAlbumContents(event.albumId);
    });
    on<GotAlbumContentsEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        _singleAlbumService.updateAlbumImagesToRepository(
            event.albumId, event.response.payload);

        emit(const SingleAlbumFetched());
      } else {
        errorHandler(emit, event.response.payload);
      }
    });

    on<UpdateAlbumEvent>((event, emit) {
      _singleAlbumService.requestUpdateAlbum(event.albumData);
    });
    on<UpdatedAlbumEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        _singleAlbumService.updateAlbum(event.request);

        emit(const AlbumUpdated());
        emit(const SingleAlbumFetched());
      } else {
        errorHandler(emit, event.response.payload);
        emit(const SingleAlbumFetched());
      }
    });

    on<AddImagesToAlbumEvent>((event, emit) {
      _singleAlbumService.addImagesToAlbum(event.albumId, event.imagesToAdd);
    });
    on<AddedImagesToAlbumEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        _singleAlbumService.updateAddedImages(
            event.request.args['album_id'].toString(),
            event.request.payload,
            DateTime.parse(event.request.args['last_modified'].toString()));

        emit(const AlbumUpdated());
        emit(const SingleAlbumFetched());
      } else {
        emit(SingleAlbumMessage(
            "Could not add images.", FotogoSnackBarIcon.error,
            exception: event.response.payload));
        emit(const SingleAlbumFetched());
      }
    });

    on<RemoveImagesFromAlbumEvent>((event, emit) {
      _singleAlbumService.removeImagesFromAlbum(
          event.albumId, event.imagesFileNamesToRemove);
    });
    on<RemovedImagesFromAlbumEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        _singleAlbumService.updateRemovedImages(
            event.request.args['album_id'].toString(),
            event.request.payload,
            DateTime.parse(event.request.args['last_modified'].toString()));

        emit(const AlbumUpdated());
        emit(const SingleAlbumFetched());
      } else {
        emit(const SingleAlbumMessage(
            "Could not remove images.", FotogoSnackBarIcon.error));
        // errorHandler(emit, event.response.payload);
        emit(const SingleAlbumFetched());
      }
    });

    on<DeleteAlbumEvent>((event, emit) {
      _singleAlbumService.deleteAlbum(event.albumId);
    });
    on<DeletedAlbumEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        final index = _albumDetailsService
            .deleteAlbum(event.request.args['album_id'].toString());

        emit(
            const SingleAlbumMessage('Album deleted', FotogoSnackBarIcon.info));
        emit(SingleAlbumDeleted(index));
      } else {
        emit(SingleAlbumMessage(
            event.response.payload, FotogoSnackBarIcon.error));
      }
    });
  }

  void errorHandler(Emitter emit, Exception e) {
    if (e is SocketException) {
      emit(SingleAlbumMessage(
          "Could not connect to server. Try checking your internet connection.",
          FotogoSnackBarIcon.error,
          exception: e));
    } else {
      emit(SingleAlbumMessage(
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
