part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  const UserEvent();
}

class UserSignInEvent extends UserEvent {
  const UserSignInEvent();
}

class UserSignInSilentlyEvent extends UserEvent {
  const UserSignInSilentlyEvent();
}

class UserSignUpEvent extends UserEvent {
  const UserSignUpEvent();
}

class UserConfirmedAccountEvent extends UserEvent {
  const UserConfirmedAccountEvent();
}

class UserSignOutEvent extends UserEvent {
  const UserSignOutEvent();
}
