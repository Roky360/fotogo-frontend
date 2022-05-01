import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:image_picker/image_picker.dart';

import 'data_types.dart';

class Client {
  late final String host;
  late final int port;
  final StreamController dataStreamController = StreamController.broadcast();

  Client(
      {required this.host,
      // String host = "192.168.1.162",
      // String host = "192.168.92.114",
      required this.port});

  void sendRequest(Sender sender) async {
    final Socket socket = await Socket.connect(host, port);
    List<int> events = Uint8List(0);

    socket.listen(
      (event) {
        events += event.toList();

        // final Response res = _parseBytesToResponse(event);
        // dataStreamController.add(sender..response = res);
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

  // Response sendRequest(Request request) {
  //   final RawSynchronousSocket socket =
  //       RawSynchronousSocket.connectSync(host, port);
  //
  //   _sendRequest(socket, request);
  //
  //   // get data length
  //   final dataLengthBytes = socket.readSync(4);
  //   final dataLength =
  //       Uint8List.fromList(dataLengthBytes!).buffer.asByteData().getInt32(0);
  //
  //   // receiving loop
  //   int bytesLeft = dataLength;
  //   List<int> dataBytes = List<int>.empty(growable: true);
  //   while (bytesLeft > 0) {
  //     final readAmount =
  //         bytesLeft.clamp(0, 16384); // max bytes to read per receive
  //     final readData = socket.readSync(readAmount)!;
  //     dataBytes += readData;
  //     bytesLeft -= readData.length;
  //   }
  //
  //   return _parseBytesToResponse(Uint8List.fromList(dataBytes));
  // }

  // void createConnection(Request request, Bloc networkingBloc,
  //     Function(Response) onDoneEvent) async {
  //   final Socket socket = await Socket.connect(_host, _port);
  //   socket.listen(
  //     (event) {
  //       final Response res = _parseBytesToResponse(event);
  //       print(res);
  //       networkingBloc.add(GotResponseEvent(onDoneEvent(res)));
  //     },
  //     onError: (error) {
  //       throw error;
  //     },
  //     onDone: () {
  //       // print('terminating...');
  //       socket.destroy();
  //     },
  //   );
  //
  //   _sendRequest(socket, request);
  // }

  // void createConnection(Request request, Function(Response) responseCallback) async {
  //   final Socket socket = await Socket.connect(_host, _port);
  //   socket.listen(
  //     (event) {
  //       final Response res = _parseBytesToResponse(event);
  //       print(res);
  //       responseCallback(res);
  //       // context.read<ServerBloc>().add(FetchedDataEvent(res));
  //     },
  //     onError: (error) {
  //       throw error;
  //     },
  //     onDone: () {
  //       // print('terminating...');
  //       socket.destroy();
  //     },
  //   );
  //
  //   _sendRequest(socket, request);
  // }

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
