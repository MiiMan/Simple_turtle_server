// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turtle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TurtleAdapter extends TypeAdapter<Turtle> {
  @override
  final int typeId = 0;

  @override
  Turtle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Turtle(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Turtle obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.x)
      ..writeByte(1)
      ..write(obj.y)
      ..writeByte(2)
      ..write(obj.z)
      ..writeByte(3)
      ..write(obj.side);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TurtleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
