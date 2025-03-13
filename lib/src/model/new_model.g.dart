// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewmodelAdapter extends TypeAdapter<Newmodel> {
  @override
  final int typeId = 0;

  @override
  Newmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Newmodel(
      title: fields[0] as String,
      description: fields[1] as String,
      url: fields[2] as String,
      imageUrl: fields[3] as String,
      source: fields[4] as String,
      publishedAt: fields[6] as String,
      content: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Newmodel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.source)
      ..writeByte(5)
      ..write(obj.content)
      ..writeByte(6)
      ..write(obj.publishedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
