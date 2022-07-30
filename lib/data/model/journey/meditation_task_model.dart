import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/meditation/rounded_image_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class MeditationTaskModel extends Equatable implements ModelFactory {
  const MeditationTaskModel({
    required this.item,
  });

  final MeditationItem item;

  factory MeditationTaskModel.fromJson(Map<String, dynamic> json) =>
      MeditationTaskModel(
        item: MeditationItem.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "item": item.toJson(),
      };

  @override
  List<Object?> get props => [item];
}

class MeditationItem extends Equatable implements ModelFactory {
  const MeditationItem({
    required this.id,
    required this.name,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    required this.playlistId,
    required this.journeyComponentId,
    required this.journeyId,
    required this.musicUrl,
    required this.roundedImage,
  });

  final int id;
  final String name;
  final String duration;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String playlistId;
  final int journeyComponentId;
  final int journeyId;
  final String musicUrl;
  final RoundedImage roundedImage;

  factory MeditationItem.fromJson(Map<String, dynamic> json) => MeditationItem(
        id: json["id"],
        name: json["name"],
        duration: json["duration"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        playlistId: json["playlist_id"],
        journeyComponentId: json["journey_component_id"],
        journeyId: json["journey_id"],
        musicUrl: json["music_url"],
        roundedImage: RoundedImage.fromJson(json["rounded_image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duration": duration,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "playlist_id": playlistId,
        "journey_component_id": journeyComponentId,
        "journey_id": journeyId,
        "music_url": musicUrl,
        "rounded_image": roundedImage.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        duration,
        createdAt,
        updatedAt,
        playlistId,
        journeyComponentId,
        journeyId,
        musicUrl,
        roundedImage,
      ];
}
