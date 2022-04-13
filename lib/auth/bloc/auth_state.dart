part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

// initial state
class SignedOut extends AuthState {
  const SignedOut();
}

class ConfirmingAccount extends AuthState {
  const ConfirmingAccount();
}

class SignedIn extends AuthState {
  const SignedIn();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
