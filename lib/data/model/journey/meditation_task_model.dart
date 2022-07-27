import 'package:kalm/data/model/meditation/playlist_model.dart';

class MeditationTaskModel {
  MeditationTaskModel({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  bool success;
  int statusCode;
  String message;
  Data? data;

  factory MeditationTaskModel.fromJson(Map<String, dynamic> json) =>
      MeditationTaskModel(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["mesage"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "mesage": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.item,
  });

  MeditationItem item;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        item: MeditationItem.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "item": item.toJson(),
      };
}

class MeditationItem {
  MeditationItem({
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

  int id;
  String name;
  String duration;
  DateTime createdAt;
  DateTime updatedAt;
  String playlistId;
  int journeyComponentId;
  int journeyId;
  String musicUrl;
  RoundedImage roundedImage;

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
}
