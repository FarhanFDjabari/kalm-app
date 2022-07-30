import 'package:equatable/equatable.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_reason_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/recomended_playlist_entity.dart';

class MoodTrackerDailyInsightEntity extends Equatable {
  const MoodTrackerDailyInsightEntity({
    required this.isTodayFinished,
    this.mood,
    this.reasons,
    this.reccomendedPlaylists,
  });

  final bool isTodayFinished;
  final int? mood;
  final List<MoodReasonEntity>? reasons;
  final List<RecomendedPlaylistEntity>? reccomendedPlaylists;

  @override
  List<Object?> get props => [
        isTodayFinished,
        mood,
        reasons,
        reccomendedPlaylists,
      ];
}
