import 'package:equatable/equatable.dart';
import 'package:kalm/domain/entity/mood_tracker/list_acc_reason_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_entity.dart';

class MoodTrackerWeeklyInsightEntity extends Equatable {
  const MoodTrackerWeeklyInsightEntity({
    required this.moodTrackers,
    required this.sortedMood,
    required this.listAccReason,
  });

  final List<MoodTrackerEntity> moodTrackers;
  final String sortedMood;
  final List<ListAccReasonEntity>? listAccReason;

  @override
  List<Object?> get props => [moodTrackers, sortedMood, listAccReason];
}
