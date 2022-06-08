part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

/// Register to  the [_dataStreamController] of [Client].
///
/// This event is called only once - when the bloc is created.
class AuthRegisterDataStreamEvent extends AuthEvent {
  const AuthRegisterDataStreamEvent();
}

/// Sign in with interactive UI.
class SignInEvent extends AuthEvent {
  const SignInEvent();
}

/// Attempt to sign in automatically without user interaction.
class SignInSilentlyEvent extends AuthEvent {
  const SignInSilentlyEvent();
}

/// Sign out from the current logged in account.
class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}

/// Sends a request to check whether a [userId] exists in the DB.
class CheckUserExistsEvent extends AuthEvent {
  final String userId;

  const CheckUserExistsEvent(this.userId);
}

class CheckedUserExistsEvent extends AuthEvent {
  final Response response;

  const CheckedUserExistsEvent(this.response);
}

/// Sends a request to create an account for the currently logged in Google
/// account.
class CreateAccountEvent extends AuthEvent {
  const CreateAccountEvent();
}

class CreatedAccountEvent extends AuthEvent {
  final Response response;

  const CreatedAccountEvent(this.response);
}

/// Sends a request to delete the account for the currently logged in Google
/// account.
class DeleteAccountEvent extends AuthEvent {
  const DeleteAccountEvent();
}

class DeletedAccountEvent extends AuthEvent {
  final Response response;

  const DeletedAccountEvent(this.response);
}
