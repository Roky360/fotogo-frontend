import 'dart:async';

import 'package:fotogo/fotogo_protocol/sender.dart';
import 'client.dart';

/// A service for the [Client] class.
class ClientService {
  final Client _client = Client(
    host: "vm128.hisham.ru",
    port: 20200,
  );

  static final ClientService _clientService = ClientService._();

  ClientService._();

  factory ClientService() => _clientService;

  StreamSubscription registerToDataStreamController(
          void Function(dynamic event)? onData) =>
      _client.dataStreamController.stream.listen(onData);

  // _client.dataStreamController.stream.listen(onData);

  /// Sends a request to the server.
  ///
  /// Formatting [Sender.request] to a [json] string and sends it over the
  /// [SecureSocket].
  void sendRequest(Sender sender) => _client.sendRequest(sender);
}
