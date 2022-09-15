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
    final response = client.fetchDailyMoodInsight(
      body: {
        "user_id": userId,
      },
    );
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
    final response = client.fetchWeeklyMoodInsight(
      body: {
        'user_id': userId,
      },
    );
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
    final response = client.postMoodTracker(
      body: {
        "user_id": userId,
        "mood": mood,
        "reasons": [...reasons],
      },
    );
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
      final result = await client.getMoodRecognition(
        body: {'image_path': imagePath},
      );

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
      final client = Supabase.instance.client;

      final fileName = image.uri.pathSegments.last;

      final storageList = await client.storage
          .from('images')
          .list(path: 'mood_images/old_service/$userId');
      final filesToRemove = storageList.data
          ?.map((e) => 'mood_images/old_service/$userId/${e.name}')
          .toList();
      await client.storage.from('images').remove(filesToRemove ?? []);

      final response = await client.storage.from('images').upload(
            'mood_images/old_service/$userId/$fileName',
            image,
          );
      if (response.error == null) {
        final publicUrlData = client.storage
            .from('images')
            .getPublicUrl('mood_images/old_service/$userId/$fileName');

        if (publicUrlData.hasError)
          throw ErrorDescription(publicUrlData.error!.message);

        return publicUrlData.data ?? "";
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }
}
