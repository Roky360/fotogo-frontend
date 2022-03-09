import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/providers/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GoogleSignInProvider _googleSignInProvider;

  GoogleSignInAccount? get user => _googleSignInProvider.user;

  String? get userName => user!.displayName?.split(' ')[0];

  UserBloc(this._googleSignInProvider) : super(UserSignedOut()) {
    on<UserSignInEvent>((event, emit) async {
      emit(UserLoading());

      try {
        if (!(await _googleSignInProvider.login())) {
          emit(UserSignedOut());
          return;
        }
        emit(UserConfirmingAccount());
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
    on<UserSignInSilentlyEvent>((event, emit) async {
      emit(UserLoading());

      try {
        if (!(await _googleSignInProvider.loginSilently())) {
          emit(UserSignedOut());
          return;
        }
        emit(UserSignedIn());
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
    on<UserSignUpEvent>((event, emit) async {
      emit(UserLoading());
    });
    on<UserConfirmedAccountEvent>((event, emit) => emit(UserSignedIn()));
    on<UserSignOutEvent>((event, emit) async {
      emit(UserLoading());

      try {
        await _googleSignInProvider.logout();

        emit(UserSignedOut());
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }

  void signOut(BuildContext context) async {
    context.read<UserBloc>().add(const UserSignOutEvent());
    if (ModalRoute.of(context)?.settings.name != '/launcher') { //TODO: change 'launcher' to checker
      Navigator.pushReplacementNamed(context, '/auth_checker');
    }
  }
}
