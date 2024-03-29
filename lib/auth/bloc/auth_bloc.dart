import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_details/album_details_service.dart';
import 'package:fotogo/auth/auth_service.dart';
import 'package:fotogo/auth/providers/google_sign_in.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:fotogo/widgets/app_widgets.dart';

part 'auth_event.dart';

part 'auth_state.dart';

/// Handles authentication, privilege levels and accounts.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignInProvider _googleSignInProvider = GoogleSignInProvider();
  final UserProvider _userProvider = UserProvider();
  final AuthService _authService = AuthService();
  final ClientService _clientService = ClientService();
  final AlbumDetailsService _albumDetailsService = AlbumDetailsService();
  final SingleAlbumService _singleAlbumService = SingleAlbumService();

  bool registeredDataListener = false;
  late final StreamSubscription dataStreamSubscription;

  AuthBloc() : super(const AuthLoading("")) {
    on<AuthRegisterDataStreamEvent>((event, emit) {
      if (registeredDataListener) return;

      dataStreamSubscription =
          _clientService.registerToDataStreamController((event) {
        if (event is! AuthSender) return;

        switch (event.requestType) {
          case RequestType.checkUserExists:
            add(CheckedUserExistsEvent(event.response));
            break;
          case RequestType.createAccount:
            add(CreatedAccountEvent(event.response));
            break;
          case RequestType.deleteAccount:
            add(DeletedAccountEvent(event.response));
            break;
          default:
            break;
        }
      });

      registeredDataListener = true;
    });
    add(const AuthRegisterDataStreamEvent());

    on<SignInEvent>((event, emit) async {
      emit(const AuthLoading("Signing in"));

      try {
        if (!(await (_googleSignInProvider.login()))) {
          // signed out
          emit(const SignedOut());
          return;
        }
        // signed in
        _userProvider.signIn(_googleSignInProvider.user!);
        add(CheckUserExistsEvent(_userProvider.id));
      } catch (e) {
        errorHandler(emit, e as Exception);
        add(const SignOutEvent());
      }
    });

    on<SignInSilentlyEvent>((event, emit) async {
      emit(const AuthLoading("", showLoadingAnimation: true));

      try {
        if (!(await _googleSignInProvider.loginSilently())) {
          // signed out
          add(const SignOutEvent());
          return;
        }
        _userProvider.signIn(_googleSignInProvider.user!);
        add(CheckUserExistsEvent(_userProvider.id));
      } catch (e) {
        errorHandler(emit, e as Exception);
        add(const SignOutEvent());
      }
    });

    on<CheckUserExistsEvent>((event, emit) {
      try {
        _authService.checkUserExists(event.userId);
      } catch (e) {
        errorHandler(emit, e as Exception);
        emit(const SignedOut());
      }
    });
    on<CheckedUserExistsEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        switch (event.response.payload) {
          case PrivilegeLevel.unregistered:
            emit(const CreatingAccount());
            break;
          case PrivilegeLevel.admin:
            emit(const AdminSignedIn());
            break;
          case PrivilegeLevel.user:
            emit(const UserSignedIn());
            break;
          default:
            errorHandler(emit, event.response.payload);
            add(const SignOutEvent());
            break;
        }
      } else {
        errorHandler(emit, event.response.payload);
        add(const SignOutEvent());
      }
    });

    on<SignOutEvent>((event, emit) async {
      emit(const AuthLoading("Loading"));

      try {
        await _googleSignInProvider.logout();
        _userProvider.signOut();

        _albumDetailsService.clear();
        _singleAlbumService.clear();
        emit(const SignedOut());
      } catch (e) {
        errorHandler(emit, e as Exception);
        emit(const SignedOut());
      }
    });

    on<CreateAccountEvent>((event, emit) {
      emit(const AuthLoading("Creating account"));

      try {
        _authService.createAccount();
      } catch (e) {
        errorHandler(emit, e as Exception);
        emit(const SignedOut());
      }
    });
    on<CreatedAccountEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        emit(const AuthMessage("Account Created", FotogoSnackBarIcon.success,
            bottomPadding: fSnackBarPaddingFromBNB));
        emit(const AuthMessage("Welcome to fotogo!", FotogoSnackBarIcon.fotogo,
            bottomPadding: fSnackBarPaddingFromBNB));
        emit(const UserSignedIn());
      } else {
        errorHandler(emit, event.response.payload);
        add(const SignOutEvent());
      }
    });

    on<DeleteAccountEvent>((event, emit) {
      emit(const AuthLoading("Loading"));

      try {
        _authService.deleteAccount();
      } catch (e) {
        errorHandler(emit, e as Exception);
      }
    });
    on<DeletedAccountEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        emit(const AuthMessage("Account Deleted", FotogoSnackBarIcon.info));
        add(const SignOutEvent());
      } else {
        errorHandler(emit, event.response.payload);
        add(const SignOutEvent());
      }
    });
  }

  void errorHandler(Emitter emit, Exception e) {
    if (e is SocketException) {
      emit(AuthMessage(
          "Could not connect to server. Try checking your internet connection.",
          FotogoSnackBarIcon.error,
          exception: e));
    } else {
      emit(AuthMessage(
          "An unexpected error occurred. Sorry for the inconvenience",
          FotogoSnackBarIcon.error,
          exception: e));
    }
    throw e;
  }

  @override
  Future<void> close() {
    dataStreamSubscription.cancel();

    return super.close();
  }
}
