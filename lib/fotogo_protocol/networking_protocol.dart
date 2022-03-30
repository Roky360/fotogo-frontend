import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'data_types.dart';

class Client {
  late final String _host;
  late final int _port;

  Client({
    String host = "157.90.143.126", // germany server
    // String host = "192.168.1.162",
    // String host = "192.168.92.114",
    int port = 20200,
  }) {
    _host = host;
    _port = port;
  }

  void createConnection(Request request, Function(Response) responseCallback) async {
    final Socket socket = await Socket.connect(_host, _port);
    socket.listen(
      (event) {
        final Response res = _parseResponse(event);
        print(res);
        responseCallback(res);
        // context.read<ServerBloc>().add(FetchedDataEvent(res));
      },
      onError: (error) {
        throw error;
      },
      onDone: () {
        // print('terminating...');
        socket.destroy();
      },
    );

    _sendRequest(socket, request);
  }

  void _sendRequest(Socket sock, Request request) {
    Map<String, Object> requestMap = {
      'request_id': request.requestType.index,
      'id_token': request.idToken!,
      'args': request.args,
      'payload': request.payload
    };

    String requestJson = json.encode(requestMap);

    int requestLength = requestJson.length;
    Uint8List requestLengthBytes = Uint8List(4)
      ..buffer.asByteData().setInt32(0, requestLength, Endian.big);

    final data = requestLengthBytes + utf8.encode(requestJson);
    sock.add(data);
  }

  Response _parseResponse(Uint8List data) {
    final responseDecoded = String.fromCharCodes(data);
    Map responseMapped = jsonDecode(responseDecoded);

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
