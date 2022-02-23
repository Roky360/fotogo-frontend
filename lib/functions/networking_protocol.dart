import 'dart:async';
import 'dart:io';

import 'dart:typed_data';

class NetworkingProtocol {
  final _host = "192.168.105.109";
  final _port = 5938;

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

    // final socket = await Socket.connect(hostname, port);

    sendRequest(socket, data);

    return response;
  }

  void sendRequest(Socket sock, List<int> data) async {
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
