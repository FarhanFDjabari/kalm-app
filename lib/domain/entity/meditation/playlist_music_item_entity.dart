import 'package:hive/hive.dart';
import 'package:kalm/data/sources/local/hive_types.dart';
import 'package:kalm/domain/entity/meditation/music_file_entity.dart';
import 'package:kalm/domain/entity/meditation/rounded_image_entity.dart';

part 'playlist_music_item_entity.g.dart';

@HiveType(typeId: HiveTypes.MUSIC)
class PlaylistMusicItemEntity extends HiveObject {
  PlaylistMusicItemEntity({
    this.id,
    this.name,
    this.duration,
    this.playlistId,
    this.musicFile,
    this.musicUrl,
    this.roundedImage,
    this.squaredImage,
  });

  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? duration;
  @HiveField(3)
  final String? playlistId;
  @HiveField(4)
  final String? musicUrl;
  // @HiveField(5)
  final MusicFileEntity? musicFile;
  @HiveField(5)
  final RoundedImageEntity? roundedImage;
  @HiveField(6)
  final RoundedImageEntity? squaredImage;
}
