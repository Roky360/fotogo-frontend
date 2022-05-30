part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

// initial state
class SignedOut extends AuthState {
  const SignedOut();
}

class CreatingAccount extends AuthState {
  const CreatingAccount();
}

/// Indicates that a user is signed in.
class UserSignedIn extends AuthState {
  const UserSignedIn();
}

/// Indicates that an admin is signed in.
class AdminSignedIn extends AuthState {
  const AdminSignedIn();
}

class AuthLoading extends AuthState {
  final String loadingMessage;
  final bool showLoadingAnimation;

  const AuthLoading(this.loadingMessage, {this.showLoadingAnimation = false});
}

class AuthMessage extends AuthState {
  final String message;
  final FotogoSnackBarIcon icon;

  const AuthMessage(this.message, this.icon);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthMessage &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
