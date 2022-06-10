part of 'admin_bloc.dart';

@immutable
abstract class AdminEvent {
  const AdminEvent();
}

/// Register to  the [_dataStreamController] of [Client].
///
/// This event is called only once - when the bloc is created.
class AdminRegisterDataStreamEvent extends AdminEvent {
  const AdminRegisterDataStreamEvent();
}

class GetStatisticsEvent extends AdminEvent {
  const GetStatisticsEvent();
}

class GotStatisticsEvent extends AdminEvent {
  final Response response;

  const GotStatisticsEvent(this.response);
}

class GetUsersData extends AdminEvent {
  const GetUsersData();
}

class GotUsersData extends AdminEvent {
  final Response response;

  const GotUsersData(this.response);
}

class DeleteUserAccountEvent extends AdminEvent {
  final String uid;

  const DeleteUserAccountEvent(this.uid);
}

class DeletedUserAccountEvent extends AdminEvent {
  final Sender sender;

  const DeletedUserAccountEvent(this.sender);
}
