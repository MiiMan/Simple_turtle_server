import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'methods.dart';


class Services {

  Router _router = Router();
  Router get router => _router;

  Methods _methods;

  Services(this._methods) {
    router
        ..post('/confirm_step', _confirmStep)
        ..get('/register', _register)
        ..get('/current_position', _getCurrentPosition);
  }

  Response _abstractMethod(Map<String, String> methodOutput) {
    switch (methodOutput['response']) {
      case 'declined': {
        return Response.internalServerError(body: 'declined by method: ${methodOutput['details']}');
      }
      case 'accepted': {
        return Response.ok(methodOutput['details']);
      }
      default: {
        return Response.notFound(methodOutput['details'] ?? 'Internal method error');
      }
    }
  }


  Future<Response> _confirmStep(Request request) async {
    int id, side;

    if (request.url.queryParameters['id'] != null ||
        request.url.queryParameters['side'] != null) {
      id = int.parse(request.url.queryParameters['id']!);
      side = int.parse(request.url.queryParameters['side']!);
    } else {
      return Response.internalServerError(body: 'params expected');
    }

    return _abstractMethod( await _methods.confirmStep( id, side ) );
  }

  Future<Response> _register(Request request) async {
    int x, y, z, side;

    if (request.url.queryParameters['x'] != null ||
        request.url.queryParameters['y'] != null ||
        request.url.queryParameters['z'] != null ||
        request.url.queryParameters['side'] != null) {
      x = int.parse(request.url.queryParameters['x']!);
      y = int.parse(request.url.queryParameters['y']!);
      z = int.parse(request.url.queryParameters['z']!);
      side = int.parse(request.url.queryParameters['side']!);
    } else {
      return Response.internalServerError(body: 'params expected');
    }

    return _abstractMethod( await _methods.register(x, y, z, side) );
  }

  Future<Response> _getCurrentPosition(Request request) async {
    int id;

    if (request.url.queryParameters['id'] != null) {
      id = int.parse(request.url.queryParameters['id']!);
    } else {
      return Response.internalServerError(body: 'params expected');
    }

    return _abstractMethod( await _methods.getCurrentPosition(id) );
  }

}