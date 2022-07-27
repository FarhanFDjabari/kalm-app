import 'package:kalm/data/model/meditation/playlist_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_daily_response.dart';

class MoodTrackerHomeResponse {
  MoodTrackerHomeResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  bool success;
  int statusCode;
  String message;
  MoodTrackerData? data;

  factory MoodTrackerHomeResponse.fromJson(Map<String, dynamic> json) =>
      MoodTrackerHomeResponse(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["mesage"],
        data: MoodTrackerData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "mesage": message,
        "data": data!.toJson(),
      };
}

class MoodTrackerData {
  MoodTrackerData({
    required this.isTodayFinished,
    this.mood,
    this.reasons,
    this.reccomendedPlaylists,
  });

  bool isTodayFinished;
  int? mood;
  List<Reason>? reasons;
  List<ReccomendedPlaylist>? reccomendedPlaylists;

  factory MoodTrackerData.fromJson(Map<String, dynamic> json) =>
      MoodTrackerData(
        isTodayFinished: json["is_today_finished"],
        mood: json["mood"] ?? 0,
        reasons: json['reasons'] != null
            ? List<Reason>.from(json["reasons"].map((x) => Reason.fromJson(x)))
            : [],
        reccomendedPlaylists: List<ReccomendedPlaylist>.from(
            json["reccomended_playlists"]
                .map((x) => ReccomendedPlaylist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "is_today_finished": isTodayFinished,
        "mood": mood,
        "reasons": List<dynamic>.from(reasons!.map((x) => x.toJson())),
        "reccomended_playlists":
            List<dynamic>.from(reccomendedPlaylists!.map((x) => x.toJson())),
      };
}

class ReccomendedPlaylist {
  ReccomendedPlaylist({
    required this.id,
    required this.name,
    required this.description,
    this.quantity,
    required this.createdAt,
    required this.topicId,
    this.description2,
    required this.roundedImage,
    this.squaredImage,
  });

  int id;
  String name;
  String description;
  String? quantity;
  DateTime createdAt;
  String topicId;
  String? description2;
  RoundedImage roundedImage;
  RoundedImage? squaredImage;

  factory ReccomendedPlaylist.fromJson(Map<String, dynamic> json) =>
      ReccomendedPlaylist(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        topicId: json["topic_id"],
        description2: json["description2"],
        roundedImage: RoundedImage.fromJson(json["rounded_image"]),
        squaredImage: RoundedImage.fromJson(json["squared_image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "quantity": quantity,
        "created_at": createdAt.toIso8601String(),
        "topic_id": topicId,
        "description2": description2,
        "rounded_image": roundedImage.toJson(),
        "squared_image": squaredImage!.toJson(),
      };
}
