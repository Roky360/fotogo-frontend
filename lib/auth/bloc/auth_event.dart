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

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}

class CheckUserExistsEvent extends AuthEvent {
  final String userId;

  const CheckUserExistsEvent(this.userId);
}

class CheckedUserExistsEvent extends AuthEvent {
  final Response response;

  const CheckedUserExistsEvent(this.response);
}

class CreateAccountEvent extends AuthEvent {
  const CreateAccountEvent();
}

class CreatedAccountEvent extends AuthEvent {
  final Response response;

  const CreatedAccountEvent(this.response);
}

class DeleteAccountEvent extends AuthEvent {
  const DeleteAccountEvent();
}

class DeletedAccountEvent extends AuthEvent {
  final Response response;

  const DeletedAccountEvent(this.response);
}
