import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/meditation/music_file_model.dart';
import 'package:kalm/data/model/meditation/rounded_image_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/meditation/playlist_music_item_entity.dart';

class PlaylistMusicItem extends Equatable implements ModelFactory {
  const PlaylistMusicItem({
    this.id,
    this.name,
    this.duration,
    this.playlistId,
    this.musicFile,
    this.musicUrl,
    this.roundedImage,
    this.squaredImage,
  });

  final int? id;
  final String? name;
  final String? duration;
  final String? playlistId;
  final String? musicUrl;
  final MusicFile? musicFile;
  final RoundedImage? roundedImage;
  final RoundedImage? squaredImage;

  factory PlaylistMusicItem.fromJson(Map<String, dynamic> json) =>
      PlaylistMusicItem(
        id: json["id"],
        name: json["name"],
        duration: json["duration"],
        musicUrl: json["music_url"],
        playlistId: json["playlist_id"],
        musicFile: MusicFile.fromJson(json["music_file"]),
        roundedImage: RoundedImage.fromJson(json["rounded_image"]),
        squaredImage: json["squared_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duration": duration,
        "playlist_id": playlistId,
        "music_url": musicUrl,
        "music_file": musicFile!.toJson(),
        "rounded_image": roundedImage!.toJson(),
        "squared_image": squaredImage,
      };

  PlaylistMusicItemEntity toEntity() {
    return PlaylistMusicItemEntity(
      id: id,
      name: name,
      duration: duration,
      playlistId: playlistId,
      musicUrl: musicUrl,
      musicFile: musicFile?.toEntity(),
      roundedImage: roundedImage?.toEntity(),
      squaredImage: squaredImage?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        duration,
        playlistId,
        musicUrl,
        musicFile,
        roundedImage,
        squaredImage,
      ];
}
