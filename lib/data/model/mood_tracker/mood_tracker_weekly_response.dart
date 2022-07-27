import 'mood_tracker_daily_response.dart';

class MoodTrackerWeeklyResponse {
  MoodTrackerWeeklyResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  bool success;
  int statusCode;
  String message;
  WeeklyInsightData? data;

  factory MoodTrackerWeeklyResponse.fromJson(Map<String, dynamic> json) =>
      MoodTrackerWeeklyResponse(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["mesage"],
        data: WeeklyInsightData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "mesage": message,
        "data": data!.toJson(),
      };
}

class WeeklyInsightData {
  WeeklyInsightData({
    required this.moodTrackers,
    required this.sortedMood,
    required this.listAccReason,
  });

  List<MoodTracker> moodTrackers;
  String sortedMood;
  List<ListAccReason>? listAccReason;

  factory WeeklyInsightData.fromJson(Map<String, dynamic> json) =>
      WeeklyInsightData(
        moodTrackers: List<MoodTracker>.from(
            json["moodTrackers"].map((x) => MoodTracker.fromJson(x))),
        sortedMood: json["sortedMood"],
        listAccReason: json['listAccReason'] != []
            ? List<ListAccReason>.from(
                json["listAccReason"].map((x) => ListAccReason.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "moodTrackers": List<dynamic>.from(moodTrackers.map((x) => x.toJson())),
        "sortedMood": sortedMood,
        "listAccReason": List<ListAccReason>.from(listAccReason!.map((x) => x)),
      };
}

class MoodTracker {
  MoodTracker({
    required this.index,
    required this.createdAt,
    required this.updatedAt,
    required this.mood,
    this.reasons,
  });

  int index;
  DateTime createdAt;
  DateTime updatedAt;
  int mood;
  List<Reason>? reasons;

  factory MoodTracker.fromJson(Map<String, dynamic> json) => MoodTracker(
        index: json["index"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        mood: json["mood"],
        reasons: json['reasons'] != []
            ? List<Reason>.from(json["reasons"].map((x) => Reason.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "mood": mood,
        "reasons": List<Reason>.from(reasons!.map((x) => x)),
      };
}

class ListAccReason {
  ListAccReason({
    required this.factor,
    required this.total,
  });

  String? factor;
  int? total;

  factory ListAccReason.fromJson(Map<String, dynamic> json) => ListAccReason(
        factor: json["factor"] != null ? json["factor"] : "Factor",
        total: json["total"] != null ? json["total"] : 0,
      );

  Map<String, dynamic> toJson() => {
        "factor": factor,
        "total": total,
      };
}
