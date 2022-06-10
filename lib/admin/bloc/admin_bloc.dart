import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fotogo/admin/admin_service.dart';
import 'package:fotogo/widgets/app_widgets.dart';

import '../../fotogo_protocol/client_service.dart';
import '../../fotogo_protocol/data_types.dart';
import '../../fotogo_protocol/sender.dart';

part 'admin_event.dart';

part 'admin_state.dart';

/// Handles the [AdminPage].
class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final ClientService _clientService = ClientService();
  final AdminService _adminService = AdminService();

  bool registeredDataListener = false;
  late final StreamSubscription dataStreamSubscription;

  AdminBloc() : super(const AdminInitial()) {
    on<AdminRegisterDataStreamEvent>((event, emit) {
      if (registeredDataListener) return;

      dataStreamSubscription =
          _clientService.registerToDataStreamController((event) {
        if (event is! AdminSender) return;

        switch (event.requestType) {
          case RequestType.generateStatistics:
            add(GotStatisticsEvent(event.response));
            break;
          case RequestType.getUsers:
            add(GotUsersData(event.response));
            break;
          case RequestType.adminDeleteUser:
            add(DeletedUserAccountEvent(event));
            break;
          default:
            break;
        }
      });

      registeredDataListener = true;
    });
    add(const AdminRegisterDataStreamEvent());

    on<GetStatisticsEvent>((event, emit) {
      emit(const AdminLoading());

      try {
        _adminService.generateStatistics();
      } catch (e) {
        emit(AdminMessage(e.toString(), FotogoSnackBarIcon.error));
      }
    });
    on<GotStatisticsEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        _adminService.updateStatistics(event.response.payload);

        emit(const StatisticsFetched());
      } else {
        emit(AdminMessage(
            event.response.payload.toString(), FotogoSnackBarIcon.error));
      }
    });

    on<GetUsersData>((event, emit) {
      emit(const AdminLoading());

      try {
        _adminService.getUsersData();
      } catch (e) {
        emit(AdminMessage(e.toString(), FotogoSnackBarIcon.error));
      }
    });
    on<GotUsersData>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        _adminService.updateUsersData(event.response.payload);

        emit(const UsersFetched());
      } else {
        emit(AdminMessage(
            event.response.payload.toString(), FotogoSnackBarIcon.error));
      }
    });

    on<DeleteUserAccountEvent>((event, emit) {
      try {
        _adminService.deleteUser(event.uid);
      } catch (e) {
        emit(AdminMessage(e.toString(), FotogoSnackBarIcon.error));
      }
    });
    on<DeletedUserAccountEvent>((event, emit) {
      final Sender sender = event.sender;

      if (sender.response.statusCode == StatusCode.ok) {
        _adminService.updateDeletedUser(sender.request.args['uid'].toString());

        emit(const UserDeleted());
        emit(const AdminMessage("User deleted", FotogoSnackBarIcon.success));
        emit(const UsersFetched());
      } else {
        emit(AdminMessage(
            sender.response.payload.toString(), FotogoSnackBarIcon.error));
      }
    });
  }

  @override
  Future<void> close() {
    dataStreamSubscription.cancel();

    return super.close();
  }
}
