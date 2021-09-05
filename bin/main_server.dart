import 'dart:async';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

import 'methods.dart';
import 'services.dart';
import 'turtle.dart';

class MainServer {

  Box<Turtle>? _box;
  Services? _services;
  Handler? _handler;

  final InternetAddress ip;
  final String port;

  MainServer(this.ip, this.port);

  Future<Box<Turtle>> _initDatabase({String name = 'data', String path = 'database'}) async{
    Hive.registerAdapter(TurtleAdapter());
    return await Hive.openBox(name, path: path);
  }

  Services _initServices(Box<Turtle> box) {
    return Services(Methods(box));
  }

  Handler _initHandler(Router router, {Function(String message, bool isError)? logger}) {
    return Pipeline().addMiddleware(logRequests(logger: logger)).addHandler(router);
  }

  Function(String message, bool isError) _streamLogger(StreamController<String> streamController) {
    return (String message, bool isError) {
      if (isError) {
        streamController.add('[ERROR] $message');
      } else {
        streamController.add(message);
      }
    };
  }

  Future<void> start({StreamController<String>? logStreamController}) async {
    _box = await _initDatabase();
    _services = _initServices(_box!);

    _handler = _initHandler(_services!.router,
        logger: logStreamController != null? _streamLogger(logStreamController) : null);

    shelf_io.serve(_handler!, ip, int.parse(port)).then((server) {
      print('Server listening on ${server.address.address}:${server.port}');
    });
  }
}