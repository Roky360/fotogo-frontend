part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthRegisterDataStreamEvent extends AuthEvent {
  const AuthRegisterDataStreamEvent();
}

class SignInEvent extends AuthEvent {
  const SignInEvent();
}

class SignInSilentlyEvent extends AuthEvent {
  const SignInSilentlyEvent();
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent();
}

class AccountConfirmedEvent extends AuthEvent {
  const AccountConfirmedEvent();
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}

class CreateAccountEvent extends AuthEvent {
  final String userId;

  const CreateAccountEvent(this.userId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateAccountEvent &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}

class CreatedAccountEvent extends AuthEvent {
  final Response response;

  const CreatedAccountEvent(this.response);
}

class DeleteAccountEvent extends AuthEvent {
  final String userId;

  const DeleteAccountEvent(this.userId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeleteAccountEvent &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}

class DeletedAccountEvent extends AuthEvent {
  final Response response;

  const DeletedAccountEvent(this.response);
}
