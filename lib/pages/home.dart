import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fotogo/theme/style.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/config/constants.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final hostname = "192.168.36.63";
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
    final socket = await Socket.connect(hostname,
            port) /*.then((Socket sock) {
      sock.listen(
        (event) {
          // handle response from server
        },
        onError: (error) {
          print("SocketError: " + error);
        },
        onDone: () {
          sock.destroy();
        },
      );
    })*/
        ;

    sendRequest(socket, data);
  }

  void sendRequest(Socket sock, List<int> data) async {
    int payloadLength = data.length;
    Uint8List bytes = Uint8List(4)
      ..buffer.asByteData().setInt32(0, payloadLength, Endian.big);
    List<int> asList = bytes;
    data = asList + data;

    print('connected');
    print(payloadLength);
    sock.add(data);
    print("DATA SENT TO SERVER");
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
                    final File? img = await pickImage();
                    if (img == null) return;

                    final imgBytes = await readFileBytes(img.path);
                    sendBytesToServer(imgBytes);
                  },
                  child: const Text("Send image to server"),
                ),
                TextButton(
                  onPressed: () {
                    if (createAlbumPanelController.isPanelShown) {
                      print('closing');
                      createAlbumPanelController.animatePanelToSnapPoint();
                      // createAlbumPanelController.close();
                      // createAlbumPanelController.hide();
                    } else {
                      print('opening');
                      createAlbumPanelController.show();
                      // createAlbumPanelController.open();
                    }
                  },
                  child: const Text("Open Create Album panel"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
