import 'package:bloc/bloc.dart';
import 'package:fotogo/auth/providers/google_sign_in.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/fotogo_protocol/client_service.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignInProvider _googleSignInProvider = GoogleSignInProvider();
  final UserProvider _userProvider = UserProvider();
  final ClientService _clientService = ClientService();

  bool registeredDataListener = false;

  AuthBloc() : super(const SignedOut()) {
    on<AuthRegisterDataStreamEvent>((event, emit) {
      if (registeredDataListener) return;

      _clientService.registerToDataStreamController((event) {
        if (event is! AuthSender) return;

        switch (event.requestType) {
          case RequestType.createAccount:
            add(CreatedAccountEvent(event.response));
            break;
          default:
            break;
        }
      });

      registeredDataListener = true;
    });
    add(const AuthRegisterDataStreamEvent());

    on<SignInEvent>((event, emit) async {
      emit(const AuthLoading());

      try {
        if (!(await (event.silent
            ? _googleSignInProvider.loginSilently()
            : _googleSignInProvider.login()))) {
          // signed out
          emit(const SignedOut());
          return;
        }
        // signed in
        _userProvider.signIn(_googleSignInProvider.user!);
        emit(const ConfirmingAccount());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // TODO: implement signup event
    on<SignUpEvent>((event, emit) => null);

    on<AccountConfirmedEvent>((event, emit) => emit(const SignedIn()));

    on<SignOutEvent>((event, emit) async {
      emit(const AuthLoading());

      try {
        await _googleSignInProvider.logout();
        _userProvider.signOut();

        emit(const SignedOut());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // TODO: delete SignUpEvent or CreateAccountEvent
    on<CreateAccountEvent>((event, emit) => null);
    on<CreatedAccountEvent>((event, emit) => null);

    on<DeleteAccountEvent>((event, emit) => null);
    on<DeletedAccountEvent>((event, emit) => null);
  }
}
