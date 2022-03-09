import 'dart:async';
import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Client {
  late final String _host;
  late final int _port;

  Client({
    host = "192.168.105.109",
    port = 5938,
  }) {
    _host = host;
    _port = port;
  }

  Future<String?> createConnection(List<int> data) async {
    String? response;

    final socket = await Socket.connect(_host, _port);
    socket.listen(
      (event) {
        // handle response from server
        response = String.fromCharCodes(event);

        // streamController.add(event);
      },
      onError: (error) {
        print("SocketError: " + error);
      },
      onDone: () {
        socket.destroy();
      },
    );

    _sendRequest(socket, data);

    return response;
  }

  void _sendRequest(Socket sock, List<int> data) async {
    int payloadLength = data.length;
    Uint8List bytes = Uint8List(4)
      ..buffer.asByteData().setInt32(0, payloadLength, Endian.big);
    List<int> asList = bytes;
    data = asList + data;

    sock.add(data);
    print("DATA SENT TO SERVER");
  }


  // Send string
  // void sendStringToServer(String data) async {
  //   print('connecting sending string');
  //   final socket = await Socket.connect(hostname, port);
  //
  //   int payloadLength = data.length;
  //   String paddedLength = payloadLength.toString().padLeft(10);
  //
  //   socket.write(paddedLength + data);
  //   print(paddedLength + data);
  //   print("DATA SENT TO SERVER");
  //   socket.close();
  // }
}


class Misc {
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    return File(image.path);

  }

  Future readFileBytes(String path) async {
    final File file = File(path);
    final bytes = await file.readAsBytes();
    return bytes;
  }
}
