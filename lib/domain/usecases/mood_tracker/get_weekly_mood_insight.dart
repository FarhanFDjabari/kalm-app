import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_weekly_insight_entity.dart';
import 'package:kalm/domain/repository/mood_tracker_repository.dart';

class GetWeeklyMoodInsight {
  final MoodTrackerRepository repository;

  GetWeeklyMoodInsight({required this.repository});

  Future<Either<String, MoodTrackerWeeklyInsightEntity>> execute(
      {required int userId}) {
    return repository.getWeeklyMoodInsight(userId: userId);
  }
}
