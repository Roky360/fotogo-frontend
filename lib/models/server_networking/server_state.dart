part of 'server_bloc.dart';

@immutable
abstract class ServerState {
  const ServerState();
}

class ServerInitial extends ServerState {
  const ServerInitial();
}

class ServerWaiting extends ServerState {
  const ServerWaiting();
}

class ServerGotData extends ServerState {
  final Response data;

  const ServerGotData(this.data);
}

class ServerError extends ServerState {
  final String message;

  const ServerError(this.message);
}
