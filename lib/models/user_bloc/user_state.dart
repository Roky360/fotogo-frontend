part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserSignedOut extends UserState {}

class UserConfirmingAccount extends UserState {}

class UserSignedIn extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  final String error;

  UserError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
