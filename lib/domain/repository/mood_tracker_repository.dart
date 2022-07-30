import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_daily_insight_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_home_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_post_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_weekly_insight_entity.dart';

abstract class MoodTrackerRepository {
  Future<Either<String, MoodTrackerHomeEntity>> getMoodTrackerHomeData(
      {required int userId});
  Future<Either<String, MoodTrackerDailyInsightEntity>> getDailyMoodInsight({
    required int userId,
  });
  Future<Either<String, MoodTrackerWeeklyInsightEntity>> getWeeklyMoodInsight({
    required int userId,
  });
  Future<Either<String, MoodTrackerPostEntity>> postMood({
    required int userId,
    required int mood,
    required List<String> reasons,
  });
}
