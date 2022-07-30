import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/mood_tracker/mood_reason_model.dart';
import 'package:kalm/data/model/mood_tracker/recomended_playlist_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_home_entity.dart';

class MoodTrackerHomeModel extends Equatable implements ModelFactory {
  const MoodTrackerHomeModel({
    required this.isTodayFinished,
    this.mood,
    this.reasons,
    this.reccomendedPlaylists,
  });

  final bool isTodayFinished;
  final int? mood;
  final List<MoodReason>? reasons;
  final List<RecomendedPlaylist>? reccomendedPlaylists;

  factory MoodTrackerHomeModel.fromJson(Map<String, dynamic> json) =>
      MoodTrackerHomeModel(
        isTodayFinished: json["is_today_finished"],
        mood: json["mood"] ?? 0,
        reasons: json['reasons'] != null
            ? List<MoodReason>.from(
                json["reasons"].map((x) => MoodReason.fromJson(x)))
            : [],
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

  MoodTrackerHomeEntity toEntity() {
    return MoodTrackerHomeEntity(
      mood: mood,
      reasons: reasons?.map((e) => e.toEntity()).toList(),
      reccomendedPlaylists:
          reccomendedPlaylists?.map((e) => e.toEntity()).toList(),
      isTodayFinished: isTodayFinished,
    );
  }

  @override
  List<Object?> get props => [
        isTodayFinished,
        mood,
        reasons,
        reccomendedPlaylists,
      ];
}
