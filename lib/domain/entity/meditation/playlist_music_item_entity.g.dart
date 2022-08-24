// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_music_item_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistMusicItemEntityAdapter
    extends TypeAdapter<PlaylistMusicItemEntity> {
  @override
  final int typeId = 1;

  @override
  PlaylistMusicItemEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistMusicItemEntity(
      id: fields[0] as int?,
      name: fields[1] as String?,
      duration: fields[2] as String?,
      playlistId: fields[3] as String?,
      musicUrl: fields[4] as String?,
      roundedImage: fields[5] as RoundedImageEntity?,
      squaredImage: fields[6] as RoundedImageEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, PlaylistMusicItemEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.playlistId)
      ..writeByte(4)
      ..write(obj.musicUrl)
      ..writeByte(5)
      ..write(obj.roundedImage)
      ..writeByte(6)
      ..write(obj.squaredImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistMusicItemEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
