import 'package:hive/hive.dart';

part 'turtle.g.dart';

@HiveType(typeId: 0)
class Turtle extends HiveObject{

  Turtle(this.x, this.y, this.z, this.side);

  @HiveField(0)
  int x;

  @HiveField(1)
  int y;

  @HiveField(2)
  int z;

  //SIDES (if look to sun): face to sun - 0, face right to sun - 1, face from sun - 2, face left to sun - 3
  @HiveField(3)
  int side;
}