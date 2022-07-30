import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_daily_insight_entity.dart';
import 'package:kalm/domain/repository/mood_tracker_repository.dart';

class GetDailyMoodInsight {
  final MoodTrackerRepository repository;

  GetDailyMoodInsight({required this.repository});

  Future<Either<String, MoodTrackerDailyInsightEntity>> execute(
      {required int userId}) {
    return repository.getDailyMoodInsight(userId: userId);
  }
}
