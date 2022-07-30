import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/mood_tracker/mood_reason_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class MoodTrackerWeeklyInsightModel extends Equatable implements ModelFactory {
  const MoodTrackerWeeklyInsightModel({
    required this.moodTrackers,
    required this.sortedMood,
    required this.listAccReason,
  });

  final List<MoodTracker> moodTrackers;
  final String sortedMood;
  final List<ListAccReason>? listAccReason;

  factory MoodTrackerWeeklyInsightModel.fromJson(Map<String, dynamic> json) =>
      MoodTrackerWeeklyInsightModel(
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

  @override
  List<Object?> get props => [moodTrackers, sortedMood, listAccReason];
}

class MoodTracker extends Equatable implements ModelFactory {
  const MoodTracker({
    required this.index,
    required this.createdAt,
    required this.updatedAt,
    required this.mood,
    this.reasons,
  });

  final int index;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int mood;
  final List<MoodReason>? reasons;

  factory MoodTracker.fromJson(Map<String, dynamic> json) => MoodTracker(
        index: json["index"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        mood: json["mood"],
        reasons: json['reasons'] != []
            ? List<MoodReason>.from(
                json["reasons"].map((x) => MoodReason.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "mood": mood,
        "reasons": List<MoodReason>.from(reasons!.map((x) => x)),
      };

  @override
  List<Object?> get props => [index, createdAt, updatedAt, mood, reasons];
}

class ListAccReason extends Equatable implements ModelFactory {
  const ListAccReason({
    required this.factor,
    required this.total,
  });

  final String? factor;
  final int? total;

  factory ListAccReason.fromJson(Map<String, dynamic> json) => ListAccReason(
        factor: json["factor"] != null ? json["factor"] : "Factor",
        total: json["total"] != null ? json["total"] : 0,
      );

  Map<String, dynamic> toJson() => {
        "factor": factor,
        "total": total,
      };

  @override
  List<Object?> get props => [factor, total];
}
