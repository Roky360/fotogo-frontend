import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:meta/meta.dart';

part 'single_album_event.dart';

part 'single_album_state.dart';

class SingleAlbumBloc extends Bloc<SingleAlbumEvent, SingleAlbumState> {
  final SingleAlbumService _singleAlbumService = SingleAlbumService();
  final ClientService _clientService = ClientService();

  bool registeredDataListener = false;

  SingleAlbumBloc() : super(const SingleAlbumInitial()) {
    on<SingleAlbumRegisterDataStreamEvent>((event, emit) {
      if (registeredDataListener) return;

      _clientService.registerToDataStreamController((event) {
        if (event is! AlbumSender) return;

        switch (event.requestType) {
          case RequestType.getAlbumContents:
            add(GotAlbumContentsEvent(event.response));
            break;
          case RequestType.updateAlbum:
            add(UpdatedAlbumEvent(event.response));
            break;
          case RequestType.addImagesToAlbum:
            add(AddedImagesToAlbumEvent(event.response));
            break;
          case RequestType.removeImagesFromAlbum:
            add(RemovedImagesFromAlbumEvent(event.response));
            break;
          case RequestType.deleteAlbum:
            add(DeletedAlbumEvent(event.response));
            break;
          default:
            break;
        }
      });

      registeredDataListener = true;
    });
    add(const SingleAlbumRegisterDataStreamEvent());

    on<GetAlbumContentsEvent>((event, emit) {
      _singleAlbumService.getAlbumDetails();
    });
    on<GotAlbumContentsEvent>((event, emit) {
      return null;
    });

    on<UpdateAlbumEvent>((event, emit) => null);
    on<UpdatedAlbumEvent>((event, emit) => null);

    on<AddImagesToAlbumEvent>((event, emit) => null);
    on<AddedImagesToAlbumEvent>((event, emit) => null);

    on<RemoveImagesFromAlbumEvent>((event, emit) => null);
    on<RemovedImagesFromAlbumEvent>((event, emit) => null);

    on<DeleteAlbumEvent>((event, emit) => null);
    on<DeletedAlbumEvent>((event, emit) => null);
  }
}
