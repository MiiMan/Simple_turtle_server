import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';

class SocketServer {

  Handler? _handler;

  final InternetAddress ip;
  final String port;

  SocketServer(this.ip, this.port);

  //idk type of webSocketChannel
  Handler _initHandler(Function(dynamic webSocketChannel) function) {
    return webSocketHandler((webSocket) {
      function(webSocket);
    });
  }

  Future<void> start(Function(dynamic webSocketChannel) function) async {
    _handler = _initHandler(function);

    shelf_io.serve(_handler!, ip, int.parse(port)).then((server) {
      print('Debug listening on ${server.address.address}:${server.port}');
    });
  }
}