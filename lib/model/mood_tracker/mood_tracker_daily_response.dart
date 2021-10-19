import 'package:kalm/model/meditation/playlist_model.dart';

class MoodTrackerDailyResponse {
  MoodTrackerDailyResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  bool success;
  int statusCode;
  String message;
  DailyInsightData? data;

  factory MoodTrackerDailyResponse.fromJson(Map<String, dynamic> json) =>
      MoodTrackerDailyResponse(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["mesage"],
        data: DailyInsightData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "mesage": message,
        "data": data!.toJson(),
      };
}

class DailyInsightData {
  DailyInsightData({
    required this.isTodayFinished,
    this.mood,
    this.reasons,
    this.reccomendedPlaylists,
  });

  bool isTodayFinished;
  int? mood;
  List<Reason>? reasons;
  List<ReccomendedPlaylist>? reccomendedPlaylists;

  factory DailyInsightData.fromJson(Map<String, dynamic> json) =>
      DailyInsightData(
        isTodayFinished: json["is_today_finished"],
        mood: json["mood"],
        reasons:
            List<Reason>.from(json["reasons"].map((x) => Reason.fromJson(x))),
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

class Reason {
  Reason({
    required this.id,
    this.reason,
    this.createdAt,
    this.updatedAt,
    required this.moodTrackerId,
  });

  int id;
  String? reason;
  DateTime? createdAt;
  DateTime? updatedAt;
  String moodTrackerId;

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
        id: json["id"],
        reason: json["reason"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        moodTrackerId: json["mood_tracker_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reason": reason,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "mood_tracker_id": moodTrackerId,
      };
}

class ReccomendedPlaylist {
  ReccomendedPlaylist({
    required this.id,
    this.name,
    this.description,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.topicId,
    this.description2,
    this.roundedImage,
    this.squaredImage,
  });

  int id;
  String? name;
  String? description;
  String? quantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? topicId;
  String? description2;
  RoundedImage? roundedImage;
  RoundedImage? squaredImage;

  factory ReccomendedPlaylist.fromJson(Map<String, dynamic> json) =>
      ReccomendedPlaylist(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "topic_id": topicId,
        "description2": description2,
        "rounded_image": roundedImage!.toJson(),
        "squared_image": squaredImage!.toJson(),
      };
}
