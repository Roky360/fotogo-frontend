part of 'admin_bloc.dart';

@immutable
abstract class AdminState {
  const AdminState();
}

class AdminInitial extends AdminState {
  const AdminInitial();
}

class AdminLoading extends AdminState {
  const AdminLoading();
}

class StatisticsFetched extends AdminState {
  const StatisticsFetched();
}

class UsersFetched extends AdminState {
  const UsersFetched();
}

class UserDeleted extends AdminState {
  const UserDeleted();
}

class AdminMessage extends AdminState {
  final String message;
  final FotogoSnackBarIcon snackBarIcon;

  const AdminMessage(this.message, this.snackBarIcon);
}
