import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/meditation/music_topic_model.dart';
import 'package:kalm/data/model/meditation/playlist_music_item_model.dart';
import 'package:kalm/data/model/meditation/rounded_image_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/meditation/playlist_entity.dart';

class PlaylistModel extends Equatable implements ModelFactory {
  const PlaylistModel({
    this.playlists,
  });

  final List<Playlist>? playlists;

  factory PlaylistModel.fromJson(Map<String, dynamic> json) => PlaylistModel(
        playlists: List<Playlist>.from(
            json["playlists"].map((x) => Playlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "playlists": List<dynamic>.from(playlists!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [playlists];
}

class Playlist extends Equatable implements ModelFactory {
  const Playlist({
    this.id,
    this.name,
    this.description,
    this.quantity,
    this.topicId,
    this.roundedImage,
    this.squaredImage,
    this.topic,
    this.playlistMusicItems,
  });

  final int? id;
  final String? name;
  final String? description;
  final String? quantity;
  final String? topicId;
  final RoundedImage? roundedImage;
  final RoundedImage? squaredImage;
  final Topic? topic;
  final List<PlaylistMusicItem>? playlistMusicItems;

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        id: json["id"],
        name: json["name"],
        description: json["description2"],
        quantity: json["quantity"],
        topicId: json["topic_id"],
        roundedImage: RoundedImage.fromJson(json["rounded_image"]),
        squaredImage: RoundedImage.fromJson(json["squared_image"]),
        topic: Topic.fromJson(json["topic"]),
        playlistMusicItems: json["playlist_music_items"] != null
            ? List<PlaylistMusicItem>.from(json["playlist_music_items"]
                .map((x) => PlaylistMusicItem.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description2": description,
        "quantity": quantity,
        "topic_id": topicId,
        "rounded_image": roundedImage!.toJson(),
        "squared_image": squaredImage!.toJson(),
        "topic": topic!.toJson(),
        "playlist_music_items":
            List<dynamic>.from(playlistMusicItems!.map((x) => x.toJson())),
      };

  PlaylistEntity toEntity() {
    return PlaylistEntity(
      id: id,
      name: name,
      topicId: topicId,
      topic: topic?.toEntity(),
      description: description,
      quantity: quantity,
      playlistMusicItems: playlistMusicItems?.map((e) => e.toEntity()).toList(),
      roundedImage: roundedImage?.toEntity(),
      squaredImage: squaredImage?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        quantity,
        topicId,
        roundedImage,
        squaredImage,
        topic,
        playlistMusicItems,
      ];
}
