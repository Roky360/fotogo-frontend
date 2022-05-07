import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, "cert.pem");
    ByteData data = await rootBundle.load("assets/server2.pem");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    // log(String.fromCharCodes(bytes));

    _securityContext = SecurityContext.defaultContext
      ..useCertificateChain(dbPath);
  }

  void sendRequest(Sender sender) async {
    // final SecureSocket socket =
    //     await SecureSocket.connect(host, port, context: _securityContext);
    final Socket socket = await Socket.connect(host, port);
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

    // log(requestMap.toString());
    String requestJson = json.encode(requestMap);
    List<int> requestBytes = utf8.encode(requestJson);

    int requestLength = requestBytes.length;
    Uint8List requestLengthBytes = Uint8List(4)
      ..buffer.asByteData().setInt32(0, requestLength, Endian.big);

    final List<int> data = requestLengthBytes + requestBytes;
    // log(requestJson);
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
