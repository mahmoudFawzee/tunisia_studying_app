// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeWorkAdapter extends TypeAdapter<Homework> {
  @override
  final int typeId = 0;

  @override
  Homework read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Homework()
      ..homeworkName = fields[0] as String
      ..done = fields[1] as bool
      ..homeworkTime = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Homework obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.homeworkName)
      ..writeByte(1)
      ..write(obj.done)
      ..writeByte(2)
      ..write(obj.homeworkTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeWorkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
