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
    final socket = await Socket.connect("192.168.1.196", 4550);
    // final socket = await Socket.connect("192.168.1.102", 4550);

    int payloadLength = data.length;
    data.insert(0, payloadLength);

    print('connected');
    print(payloadLength);
    socket.add(data);
    print("DATA SENT TO SERVER");
    socket.close();
  }

  void sendStringToServer(String data) async {
    print('connecting');
    final socket = await Socket.connect("192.168.1.196", 4550);
    // final socket = await Socket.connect("192.168.1.102", 4550);

    int payloadLength = data.length;

    socket.write(payloadLength.toString() + data);
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

                    print(imgBytes);

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
