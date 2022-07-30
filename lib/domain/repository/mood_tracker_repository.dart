import 'package:kalm/domain/entity/mood_tracker/mood_tracker_daily_insight_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_home_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_post_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_weekly_insight_entity.dart';

abstract class MoodTrackerRepository {
  Future<MoodTrackerHomeEntity> getMoodTrackerHomeData({required int userId});
  Future<MoodTrackerDailyInsightEntity> getDailyMoodInsight({
    required int userId,
  });
  Future<MoodTrackerWeeklyInsightEntity> getWeeklyMoodInsight({
    required int userId,
  });
  Future<MoodTrackerPostEntity> postMood({
    required int userId,
    required int mood,
    required List<String> reasons,
  });
}
