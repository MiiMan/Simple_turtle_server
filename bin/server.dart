import 'dart:async';
import 'dart:io';

import 'main_server.dart';
import 'socket_server.dart';

void main(List<String> args) async {
  StreamController<String> outputStreamController = StreamController();

  SocketServer socketServer = SocketServer(InternetAddress.anyIPv4, '4567');
  MainServer mainServer = MainServer(InternetAddress.anyIPv4, Platform.environment['PORT'] ?? '8080');

  await socketServer.start((webSocketChannel) {
    outputStreamController.stream.listen((event) {
      webSocketChannel.sink.add(event);
      print(event);
    });
  });
  await mainServer.start(logStreamController: outputStreamController);

}

