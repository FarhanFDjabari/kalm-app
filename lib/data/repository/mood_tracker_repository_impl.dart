import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/moodtracker/mood_recognition_service.dart';
import 'package:kalm/data/sources/remote/services/moodtracker/mood_tracker_service.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_weekly_insight_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_post_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_home_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_daily_insight_entity.dart';
import 'package:kalm/domain/repository/mood_tracker_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      final client = SupabaseClient('https://xtxiyjuvarutzorjpudq.supabase.co',
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh0eGl5anV2YXJ1dHpvcmpwdWRxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjEyNzQ0MDUsImV4cCI6MTk3Njg1MDQwNX0.XOeN0u6qNEOJ7wJrorI3U5FPAC4Uo97AvU8t8WTAu20');
      final fileName = image.uri.pathSegments.last;

      final storageList = await client.storage
          .from('images')
          .list(path: '/mood_images/$userId');
      final filesToRemove = storageList.data
          ?.map((e) => '/mood_images/$userId/${e.name}')
          .toList();
      await client.storage.from('images').remove(filesToRemove ?? []);

      final response = await client.storage.from('images').upload(
            '/mood_images/$userId/$fileName',
            image,
          );
      if (response.error == null) {
        return response.data ?? "";
      }
      return response.error!.message;
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }
}
