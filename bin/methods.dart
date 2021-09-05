import 'dart:convert';

import 'package:hive/hive.dart';

import 'turtle.dart';

class Methods {

  static const Map<String, String> _accepted = const {'response': 'accepted'};
  static const Map<String, String> _declined = const {'response': 'declined'};

  Box<Turtle> _box;
  Methods(this._box);

  Future<Map<String, String>> register(int x, int y, int z, int side) async {

    int id = await _box.add(Turtle(x, y, z, side));
    return Map.from(_accepted)..['details'] = id.toString();
  }

  Future<Map<String, String>> confirmStep(int id, int side) async {

    Turtle? turtle = _box.getAt(id);

    if (turtle == null) {
      return Map.from(_declined)..['details'] = 'Wrong id';
    }

    switch (side) {
      case 0: {
        turtle.x += 1;
        turtle.side = side;
        break;
      }
      case 1: {
        turtle.z += 1;
        turtle.side = side;
        break;
      }
      case 2: {
        turtle.x -= 1;
        turtle.side = side;
        break;
      }
      case 3: {
        turtle.z -= 1;
        turtle.side = side;
        break;
      }
      case 4: {
        turtle.y += 1;
        break;
      }
      case 5: {
        turtle.y -= 1;
        break;
      }
      default: {
        return Map.from(_declined)..['details'] = 'Wrong side';
      }
    }
    turtle.save();
    return Map.from(_accepted)..['details'] = '';
  }

  Future<Map<String, String>> getCurrentPosition(int id) async {
    Turtle? turtle = _box.getAt(id);

    if (turtle == null) {
      return Map.from(_declined)..['details'] = 'Wrong id';
    }

    return Map.from(_accepted)..['details'] = jsonEncode({'x': turtle.x, 'y': turtle.y, 'z': turtle.z, 'side': turtle.side});
  }

}