import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/meditation/music_file_model.dart';
import 'package:kalm/data/model/meditation/rounded_image_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class MusicModel extends Equatable implements ModelFactory {
  const MusicModel({
    this.music,
  });

  final List<Music>? music;

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
        music: List<Music>.from(json["music"].map((x) => Music.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "music": List<dynamic>.from(music!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [music];
}

class Music extends Equatable implements ModelFactory {
  const Music({
    this.id,
    this.name,
    this.duration,
    this.playlistId,
    this.musicUrl,
    this.musicFile,
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

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        id: json["id"],
        name: json["name"],
        duration: json["duration"],
        playlistId: json["playlist_id"],
        musicUrl: json["music_url"],
        musicFile: MusicFile.fromJson(json["music_file"]),
        roundedImage: json["rounded_image"],
        squaredImage: json["squared_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duration": duration,
        "playlist_id": playlistId,
        "music_url": musicUrl,
        "music_file": musicFile!.toJson(),
        "rounded_image": roundedImage,
        "squared_image": squaredImage,
      };

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
