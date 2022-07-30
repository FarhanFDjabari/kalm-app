import 'package:kalm/data/sources/remote/services/moodtracker/mood_tracker_service.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_weekly_insight_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_post_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_home_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_daily_insight_entity.dart';
import 'package:kalm/domain/repository/mood_tracker_repository.dart';

class MoodTrackerRepositoryImpl extends MoodTrackerRepository {
  final MoodTrackerService service;

  MoodTrackerRepositoryImpl({required this.service});

  @override
  Future<MoodTrackerDailyInsightEntity> getDailyMoodInsight(
      {required int userId}) {
    // TODO: implement getDailyMoodInsight
    throw UnimplementedError();
  }

  @override
  Future<MoodTrackerHomeEntity> getMoodTrackerHomeData({required int userId}) {
    // TODO: implement getMoodTrackerHomeData
    throw UnimplementedError();
  }

  @override
  Future<MoodTrackerWeeklyInsightEntity> getWeeklyMoodInsight(
      {required int userId}) {
    // TODO: implement getWeeklyMoodInsight
    throw UnimplementedError();
  }

  @override
  Future<MoodTrackerPostEntity> postMood(
      {required int userId, required int mood, required List<String> reasons}) {
    // TODO: implement postMood
    throw UnimplementedError();
  }
}
