import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:fotogo/functions/file_handling.dart';
import 'package:image_picker/image_picker.dart';

import 'data_types.dart';

class Client {
  late final String host;
  late final int port;
  final StreamController dataStreamController = StreamController.broadcast();
  late final SecurityContext _securityContext;

  Client(
      {required this.host,
      // String host = "192.168.1.162",
      // String host = "192.168.92.114",
      required this.port}) {
    initializeCert();
  }

  void initializeCert() async {
    List<int> certBytes = await readAssetBytes("assets/cert.pem");
    List<int> privateKeyBytes = await readAssetBytes("assets/privkey.pem");

    _securityContext = SecurityContext.defaultContext;
    _securityContext.useCertificateChainBytes(certBytes);
    _securityContext.usePrivateKeyBytes(privateKeyBytes);
  }

  void sendRequest(Sender sender) async {
    final SecureSocket socket =
        await SecureSocket.connect(host, port, context: _securityContext);
    // final Socket socket = await Socket.connect(host, port);
    List<int> events = Uint8List(0);

    socket.listen(
      (event) {
        events += event.toList();
      },
      onError: (error) {
        throw error;
      },
      onDone: () {
        final Response res = _parseBytesToResponse(Uint8List.fromList(events));
        dataStreamController.add(sender..response = res);

        socket.destroy();
      },
    );

    _sendRequest(socket, sender.request);
  }

  void _sendRequest(Socket sock, Request request) {
    Map<String, Object> requestMap = {
      'request_id': request.requestType.index,
      'id_token': request.idToken!,
      'args': request.args,
      'payload': request.payload
    };

    String requestJson = json.encode(requestMap);
    List<int> requestBytes = utf8.encode(requestJson);

    int requestLength = requestBytes.length;
    Uint8List requestLengthBytes = Uint8List(4)
      ..buffer.asByteData().setInt32(0, requestLength, Endian.big);

    final List<int> data = requestLengthBytes + requestBytes;

    sock.add(data);
  }

  Response _parseBytesToResponse(Uint8List data) {
    final responseDecoded = String.fromCharCodes(data);
    final Map responseMapped = jsonDecode(responseDecoded);

    return Response(
      statusCode: responseMapped['status_code'],
      payload: responseMapped['payload'],
    );
  }
}

class Misc {
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    return File(image.path);
  }
}
