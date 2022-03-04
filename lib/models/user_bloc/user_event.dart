part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  const UserEvent();
}

class UserSignInEvent extends UserEvent {
  const UserSignInEvent();
}

class UserSignUpEvent extends UserEvent {
  const UserSignUpEvent();
}

class UserSignOutEvent extends UserEvent {
  const UserSignOutEvent();
}
