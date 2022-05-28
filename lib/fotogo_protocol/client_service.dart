import 'dart:async';

import 'package:fotogo/fotogo_protocol/sender.dart';

import 'client.dart';

class ClientService {
  final Client _client = Client(host: "vm128.hisham.ru", port: 20200);

  static final ClientService _clientService = ClientService._();

  ClientService._();

  factory ClientService() => _clientService;

  StreamSubscription registerToDataStreamController(
          void Function(dynamic event)? onData) =>
      _client.dataStreamController.stream.listen(onData);

  void sendRequest(Sender sender) => _client.sendRequest(sender);
}
