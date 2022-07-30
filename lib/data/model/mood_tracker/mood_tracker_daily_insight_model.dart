import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/mood_tracker/mood_reason_model.dart';
import 'package:kalm/data/model/mood_tracker/recomended_playlist_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class MoodTrackerDailyInsightModel extends Equatable implements ModelFactory {
  const MoodTrackerDailyInsightModel({
    required this.isTodayFinished,
    this.mood,
    this.reasons,
    this.reccomendedPlaylists,
  });

  final bool isTodayFinished;
  final int? mood;
  final List<MoodReason>? reasons;
  final List<RecomendedPlaylist>? reccomendedPlaylists;

  factory MoodTrackerDailyInsightModel.fromJson(Map<String, dynamic> json) =>
      MoodTrackerDailyInsightModel(
        isTodayFinished: json["is_today_finished"],
        mood: json["mood"],
        reasons: List<MoodReason>.from(
            json["reasons"].map((x) => MoodReason.fromJson(x))),
        reccomendedPlaylists: List<RecomendedPlaylist>.from(
            json["reccomended_playlists"]
                .map((x) => RecomendedPlaylist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "is_today_finished": isTodayFinished,
        "mood": mood,
        "reasons": List<dynamic>.from(reasons!.map((x) => x.toJson())),
        "reccomended_playlists":
            List<dynamic>.from(reccomendedPlaylists!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        isTodayFinished,
        mood,
        reasons,
        reccomendedPlaylists,
      ];
}
