import 'dart:io';

class SocketConnection {
  SocketConnection();

  Future<String> con() async {
    String indexRequest = 'FLUTTER GET / HTTP/1.1\nConnection: close\n\n';
    String d = '';

    await Socket.connect('192.168.16.126', 4567).then((socket) {
      print('Connected to: '
          '${socket.remoteAddress.address}:${socket.remotePort}');

      //Establish the onData, and onDone callbacks
      socket.listen((data) {
        d = String.fromCharCodes(data);
        print(d);
      }, onDone: () {
        print("Done");
        socket.write("Erhalten");
        socket.destroy();
      });

      //Send the request
      socket.write(indexRequest);
    });
    return d;
  }
}
