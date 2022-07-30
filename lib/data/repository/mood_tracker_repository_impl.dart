import 'package:dartz/dartz.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
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
  Future<Either<String, MoodTrackerDailyInsightEntity>> getDailyMoodInsight(
      {required int userId}) async {
    await service
        .fetchDailyMoodInsight(userId: userId)
        .validateStatus()
        .then((response) {
      return Right(response.data!.toEntity());
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, MoodTrackerHomeEntity>> getMoodTrackerHomeData(
      {required int userId}) async {
    await service
        .fetchHomeData(userId: userId)
        .validateStatus()
        .then((response) {
      return Right(response.data!.toEntity());
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, MoodTrackerWeeklyInsightEntity>> getWeeklyMoodInsight(
      {required int userId}) async {
    await service
        .fetchWeeklyMoodInsight(userId: userId)
        .validateStatus()
        .then((response) {
      return Right(response.data!.toEntity());
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, MoodTrackerPostEntity>> postMood(
      {required int userId,
      required int mood,
      required List<String> reasons}) async {
    await service
        .postMoodTracker(userId: userId, mood: mood, reasons: reasons)
        .validateStatus()
        .then((response) {
      return Right(response.data!.toEntity());
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }
}
