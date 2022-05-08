import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fotogo/album_details/album_details_service.dart';
import 'package:fotogo/auth/auth_service.dart';
import 'package:fotogo/auth/providers/google_sign_in.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

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
        emit(AuthMessage(e.toString(), FotogoSnackBarIcon.error));
      }
    });

    on<SignInSilentlyEvent>((event, emit) async {
      emit(const AuthLoading("", showLoadingAnimation: true));

      try {
        if (!(await _googleSignInProvider.loginSilently())) {
          // signed out
          emit(const SignedOut());
          return;
        }
        _userProvider.signIn(_googleSignInProvider.user!);
        add(CheckUserExistsEvent(_userProvider.id));
        // emit(const SignedIn());
      } catch (e) {
        emit(AuthMessage(e.toString(), FotogoSnackBarIcon.error));
        emit(const SignedOut());
      }
    });

    on<CheckUserExistsEvent>((event, emit) {
      _authService.checkUserExists(event.userId);
    });
    on<CheckedUserExistsEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        if (event.response.payload as bool) {
          emit(const SignedIn());
        } else {
          emit(const ConfirmingAccount());
        }
      } else {
        emit(AuthMessage(event.response.payload, FotogoSnackBarIcon.error));
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
        emit(AuthMessage(e.toString(), FotogoSnackBarIcon.error));
      }
    });

    on<CreateAccountEvent>((event, emit) {
      emit(const AuthLoading("Creating account"));

      try {
        _authService.createAccount();
      } catch (e) {
        emit(AuthMessage(e.toString(), FotogoSnackBarIcon.error));
      }
    });
    on<CreatedAccountEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        emit(const AuthMessage("Account Created", FotogoSnackBarIcon.success));
        emit(
            const AuthMessage("Welcome to fotogo!", FotogoSnackBarIcon.fotogo));
        emit(const SignedIn());
      } else {
        emit(AuthMessage(event.response.payload, FotogoSnackBarIcon.error));
      }
    });

    on<DeleteAccountEvent>((event, emit) {
      emit(const AuthLoading("Loading"));

      try {
        _authService.deleteAccount();
      } catch (e) {
        emit(AuthMessage(e.toString(), FotogoSnackBarIcon.error));
      }
    });
    on<DeletedAccountEvent>((event, emit) {
      if (event.response.statusCode == StatusCode.ok) {
        emit(const AuthMessage("Account Deleted", FotogoSnackBarIcon.info));
        add(const SignOutEvent());
      } else {
        emit(AuthMessage(event.response.payload, FotogoSnackBarIcon.error));
      }
    });
  }

  @override
  Future<void> close() {
    dataStreamSubscription.cancel();

    return super.close();
  }
}
