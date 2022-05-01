import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fotogo/album_creation/album_creation_data.dart';
import 'package:fotogo/album_creation/album_creation_service.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:meta/meta.dart';

part 'album_creation_event.dart';

part 'album_creation_state.dart';

class AlbumCreationBloc extends Bloc<AlbumCreationEvent, AlbumCreationState> {
  final AlbumCreationService _albumCreationService = AlbumCreationService();
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
        emit(AlbumCreationError(e.toString()));
      }
    });
    on<CreatedAlbumEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.created) {
        // TODO: add new single_album to single_album repo
        _albumCreationService.addCreatedAlbumToRepository(
            event.request, event.response);
        emit(const AlbumCreated());
      } else {
        emit(AlbumCreationError(event.response.payload));
      }
    });
  }

  @override
  Future<void> close() {
    dataStreamSubscription.cancel();

    return super.close();
  }
}
