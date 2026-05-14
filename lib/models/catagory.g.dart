// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catagory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatagoryAdapter extends TypeAdapter<Catagory> {
  @override
  final int typeId = 0;

  @override
  Catagory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Catagory(
      title: fields[0] as String,
      description: fields[1] as String?,
      isCompleted: fields[2] as bool,
      color: Color.fromARGB(99, 236, 125, 125),
    )..colorValue = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, Catagory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.colorValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatagoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
