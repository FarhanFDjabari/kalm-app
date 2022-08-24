// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rounded_image_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoundedImageEntityAdapter extends TypeAdapter<RoundedImageEntity> {
  @override
  final int typeId = 2;

  @override
  RoundedImageEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoundedImageEntity(
      url: fields[0] as String?,
      thumbnail: fields[1] as String?,
      preview: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RoundedImageEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.thumbnail)
      ..writeByte(2)
      ..write(obj.preview);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoundedImageEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
