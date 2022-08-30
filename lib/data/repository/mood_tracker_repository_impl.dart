import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/moodtracker/mood_recognition_service.dart';
import 'package:kalm/data/sources/remote/services/moodtracker/mood_tracker_service.dart';
import 'package:kalm/data/sources/remote/services/moodtracker/mood_tracker_service_supa.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_weekly_insight_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_post_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_home_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_daily_insight_entity.dart';
import 'package:kalm/domain/repository/mood_tracker_repository.dart';

class MoodTrackerRepositoryImpl extends MoodTrackerRepository {
  @override
  Future<Either<String, MoodTrackerDailyInsightEntity>> getDailyMoodInsight(
      {required int userId}) async {
    try {
      final client = moodTrackerServiceSupa;
      final result = await client.fetchDailyMoodInsight(userId: userId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, MoodTrackerHomeEntity>> getMoodTrackerHomeData(
      {required int userId}) async {
    try {
      final client = moodTrackerServiceSupa;
      final result = await client.fetchHomeData(userId: userId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, MoodTrackerWeeklyInsightEntity>> getWeeklyMoodInsight(
      {required int userId}) async {
    try {
      final client = moodTrackerServiceSupa;
      final result = await client.fetchWeeklyMoodInsight(userId: userId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, MoodTrackerPostEntity>> postMood(
      {required int userId,
      required int mood,
      required List<String> reasons}) async {
    try {
      final client = moodTrackerServiceSupa;
      final result = await client.postMoodTracker(
          userId: userId, mood: mood, reasons: reasons);
      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getMoodRecognition(
      {required String imagePath}) async {
    try {
      final client = await moodRecognitionService();
      final result = await client.getMoodRecognition(imagePath: imagePath);

      if (result != null) {
        return Right(result as Map<String, dynamic>);
      }
      return Left('Failed get mood prediction');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<String> postMoodImage(
      {required File image, required int userId}) async {
    try {
      final client = moodTrackerServiceSupa;
      final result = await client.postMoodImage(image: image, userId: userId);

      return result;
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }
}
