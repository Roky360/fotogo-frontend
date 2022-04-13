import 'package:fotogo/fotogo_protocol/sender.dart';

import 'client.dart';

class ClientService {
  final Client _client = Client(host: "157.90.143.126", port: 20200);

  static final ClientService _clientService = ClientService._();

  ClientService._();

  factory ClientService() => _clientService;

  void registerToDataStreamController(void Function(dynamic event)? onData) =>
      _client.dataStreamController.stream.listen(onData);

  void sendRequest(Sender sender) => _client.sendRequest(sender);
}
