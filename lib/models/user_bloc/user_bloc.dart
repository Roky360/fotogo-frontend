import 'package:bloc/bloc.dart';
import 'package:fotogo/providers/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GoogleSignInProvider _googleSignInProvider;

  GoogleSignInAccount? get user => _googleSignInProvider.user;

  UserBloc(this._googleSignInProvider) : super(UserSignedOut()) {
    on<UserSignInEvent>((event, emit) async {
      emit(UserLoading());

      try {
        if (!await _googleSignInProvider.login()) {
          emit(UserSignedOut());
          return;
        }
        emit(UserConfirmingAccount());
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
    on<UserSignUpEvent>((event, emit) async {
      emit(UserLoading());
    });
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
}
