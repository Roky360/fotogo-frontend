import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:hex/hex.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final hostname = "192.168.105.184";
  final port = 5938;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    return File(image.path);
  }

  Future readFileBytes(String path) async {
    final File file = File(path);

    final a = await file.readAsBytes();

    // print(a);

    return a;
  }
  
  void sendBytesToServer(List<int> data) async {
    print('connecting');
    final socket = await Socket.connect(hostname, port).then((Socket sock) {
      sock.listen((event) {
        // handle response from server
      },
        onError: (error) {
          print("SocketError: " + error);
        },
        onDone: () {
          sock.destroy();
        },
      );
    });

    sendRequest(socket, data);
  }

  void sendRequest(Socket sock, List<int> data) async {
    int payloadLength = data.length;
    Uint8List bytes = Uint8List(4)..buffer.asByteData().setInt32(0, payloadLength, Endian.big);
    List<int> asList = bytes;
    data = asList + data;

    print('connected');
    print(payloadLength);
    sock.add(data);
    print("DATA SENT TO SERVER");
  }

  void sendStringToServer(String data) async {
    print('connecting sending string');
    final socket = await Socket.connect(hostname, port);

    int payloadLength = data.length;
    String paddedLength = payloadLength.toString().padLeft(10);

    socket.write(paddedLength + data);
    print(paddedLength + data);
    print("DATA SENT TO SERVER");
    socket.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                fotogoLogo(),
                TextButton(
                  onPressed: () async {
                    File img = await pickImage();
                    // if (img == null) return;

                    final imgBytes = await readFileBytes(img.path);

                    // print(imgBytes);

                    sendBytesToServer(imgBytes);

                    // final imgBytes = readBytes(img.path);
                    // print(imgBytes);
                    // sendToServer(imgBytes);
                  },
                  child: const Text("Send image to server"),
                ),
                TextButton(
                  onPressed: () async {
                    sendStringToServer("hello :P");
                  },
                  child: const Text("Send 'hello' to the server"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
