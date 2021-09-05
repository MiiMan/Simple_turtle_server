import 'dart:io';

import 'package:hive/hive.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import 'methods.dart';
import 'services.dart';
import 'turtle.dart';

void main(List<String> args) async {

  late Box<Turtle> box;

  Hive.registerAdapter(TurtleAdapter());

  box = await Hive.openBox('data', path: 'database');

  final Services methods = Services(Methods(box));
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final _handler = Pipeline().addMiddleware(logRequests()).addHandler(methods.router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(_handler, ip, port);
  print('Server listening on port ${server.port}');
}
