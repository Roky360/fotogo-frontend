import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:fotogo/fotogo_protocol/sender.dart';
import 'package:fotogo/functions/file_handling.dart';

import 'data_types.dart';

/// A socket client that sends request to the server with a secure connection
/// via [SecureSocket].
class Client {
  late final String host;
  late final int port;
  late final SecurityContext _securityContext;

  late final StreamController dataStreamController =
      StreamController.broadcast();

  Client({
    required this.host,
    required this.port,
  }) {
    // _initializeCert();
  }

  /// Initializes the [SecurityContext] with the server's certificate and
  /// private key.
  ///
  /// The [SecurityContext] is used by the [SecureSocket].
  void _initializeCert() async {
    List<int> certBytes = await readAssetBytes("assets/cert.pem");
    List<int> privateKeyBytes = await readAssetBytes("assets/privkey.pem");

    _securityContext = SecurityContext.defaultContext;
    _securityContext.useCertificateChainBytes(certBytes);
    _securityContext.usePrivateKeyBytes(privateKeyBytes);
  }

  /// Sends a request to the server in a JSON string form.
  ///
  /// Accepts a [Sender] object, which contains the [RequestType] of the
  /// request and a [Request] object pre defined.
  ///
  /// The method converts the [Request] to a JSON string, encodes it and sends
  /// it over the [SecureSocket].
  ///
  /// When receiving data, parse it to [Response] object, adds it to the same
  /// [Sender] object and adds it to the [dataStreamController].
  void sendRequest(Sender sender) async {
    try {
      print("Connecting, port $port and host $host");
      // final SecureSocket socket = await SecureSocket.connect(host, port,
      //     context: _securityContext, onBadCertificate: (_) {
      //   print("SSL certificate invalid.");
      //   return true;
      // });
      final Socket socket = await Socket.connect(host, port);
      print("Connected!!!!!");
      List<int> events = Uint8List(0);

      socket.listen(
        (event) {
          events += event.toList();
        },
        onError: (error) {
          handleError(sender, error);
          socket.destroy();
        },
        onDone: () {
          try {
            final Response res =
                _parseBytesToResponse(Uint8List.fromList(events));
            dataStreamController.add(sender..response = res);
          } catch (e) {
            handleError(sender, e as Exception);
            socket.destroy();
          }
        },
      );

      _sendRequest(socket, sender.request);
    } catch (e) {
      handleError(sender, e as Exception);
    }
  }

  /// Converting [request] to JSON string, then sends it to [sock] encoded.
  ///
  /// Converting [request] to JSON string, encodes it with [utf8], adding the
  /// length of the JSON string before it as bytes, then adds all to [sock].
  void _sendRequest(/*SecureSocket*/ Socket sock, Request request) {
    Map<String, Object> requestMap = {
      'request_id': request.requestType.index,
      'id_token': request.idToken!,
      'args': request.args,
      'payload': request.payload
    };

    String requestJson = json.encode(requestMap);
    List<int> requestBytes = utf8.encode(requestJson);

    int requestLength = requestBytes.length;
    Uint8List requestLengthBytes = Uint8List(4)
      ..buffer.asByteData().setInt32(0, requestLength, Endian.big);

    final List<int> data = requestLengthBytes + requestBytes;

    sock.add(data);
  }

  /// Parses raw [data], containing response as JSON string to [Request] object.
  ///
  /// Decodes [data] and coverts it to [Map]. Then returning [Response] and
  /// filling its status_code and payload fields from the [Map].
  Response _parseBytesToResponse(Uint8List data) {
    final responseDecoded = String.fromCharCodes(data);
    final Map responseMapped = jsonDecode(responseDecoded);

    return Response(
      statusCode: responseMapped['status_code'],
      payload: responseMapped['payload'],
    );
  }

  void handleError(Sender sender, Exception e) {
    dataStreamController
        .add(sender..response = Response(statusCode: -1, payload: e));
  }
}
