import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ip = "192.168.1.196";
  final port = 8000;

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
    final socket = await Socket.connect(ip, port);
    // final socket = await Socket.connect("192.168.1.102", 4550);

    int payloadLength = data.length;
    print(payloadLength);
    Uint8List bytes = Uint8List(4)..buffer.asByteData().setInt32(0, payloadLength, Endian.big);
    List<int> asList = bytes;
    data = asList + data;

    print('connected');
    socket.add(data);
    print("DATA SENT TO SERVER");
    socket.close();
  }

  void sendStringToServer(String data) async {
    print('connecting sending hello');
    final socket = await Socket.connect(ip, port);

    int payloadLength = data.length;
    String lengthPadded = payloadLength.toString().padLeft(10);

    socket.write(data);
    // socket.write(lengthPadded + data);
    print("DATA SENT TO SERVER");
    socket.close();
  }
  
  void test() {
    int len = 257;
    
    // print(Uint8List.fromList([(len).toRadixString(16)]));
    print(Uint8List.fromList([len]));
    debugPrint(len.toString().padLeft(8, '0'));
    List<int> a = [];
    while (len > 0) {
      a.insert(-1, len % 10);
      // len /= 10;
    }
    // print(Uint8List.fromList(elements));
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
                    // test();
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
