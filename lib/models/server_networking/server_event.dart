part of 'server_bloc.dart';

@immutable
abstract class ServerEvent {
  const ServerEvent();
}

class FetchDataEvent extends ServerEvent {
  final Request request;

  const FetchDataEvent(this.request);
}

class FetchedDataEvent extends ServerEvent {
  final Response response;

  const FetchedDataEvent(this.response);
}
