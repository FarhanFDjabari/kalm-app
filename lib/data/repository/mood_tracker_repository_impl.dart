import 'package:dartz/dartz.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/moodtracker/mood_tracker_service.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_weekly_insight_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_post_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_home_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_daily_insight_entity.dart';
import 'package:kalm/domain/repository/mood_tracker_repository.dart';

class MoodTrackerRepositoryImpl extends MoodTrackerRepository {
  @override
  Future<Either<String, MoodTrackerDailyInsightEntity>> getDailyMoodInsight(
      {required int userId}) async {
    final client = await moodTrackerClient();
    final response = client.fetchDailyMoodInsight(userId: userId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.toEntity());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, MoodTrackerHomeEntity>> getMoodTrackerHomeData(
      {required int userId}) async {
    final client = await moodTrackerClient();
    final response = client.fetchHomeData(userId: userId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.toEntity());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, MoodTrackerWeeklyInsightEntity>> getWeeklyMoodInsight(
      {required int userId}) async {
    final client = await moodTrackerClient();
    final response = client.fetchWeeklyMoodInsight(userId: userId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.toEntity());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, MoodTrackerPostEntity>> postMood(
      {required int userId,
      required int mood,
      required List<String> reasons}) async {
    final client = await moodTrackerClient();
    final response =
        client.postMoodTracker(userId: userId, mood: mood, reasons: reasons);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.toEntity());
    } else {
      return Left(result.message);
    }
  }
}
