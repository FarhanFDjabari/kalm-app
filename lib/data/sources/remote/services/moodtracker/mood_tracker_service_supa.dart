import 'package:flutter/cupertino.dart';
import 'package:kalm/data/model/mood_tracker/mood_reason_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_daily_insight_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_home_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_post_response.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_weekly_insight_model.dart';
import 'package:kalm/data/model/mood_tracker/recomended_playlist_model.dart';
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:supabase/supabase.dart';

class MoodTrackerServiceSupa {
  final client = SupabaseClient(
      ConfigEnvironments.getEnvironments(), ConfigEnvironments.getPublicKey());

  Future<MoodTrackerHomeModel> fetchHomeData({required int userId}) async {
    final response = await client.from('mood_tracker').select().eq('user_id', userId).execute();

    if (response.status! >= 200 && response.status! <= 299) {
      final moodTrackerHomeMapData =
          response.data as List<Map<String, dynamic>>;

      final moodReasons = await getMoodReason(moodTrackerId: moodTrackerHomeMapData.first['id']);

      final recomendedPlaylists = await getRecomendedPlaylist(reasons: moodReasons, moodPoint: moodTrackerHomeMapData.first['mood'],);

      return MoodTrackerHomeModel(
        isTodayFinished: isTodayFinished,
        mood: moodTrackerHomeMapData.first['mood'],
        reasons: moodReasons,
        reccomendedPlaylists: recomendedPlaylists,
      );
    }

    throw ErrorDescription(response.error!.message);
  }

  Future<List<MoodReason>> getMoodReason({required int moodTrackerId}) async {
    final response = await client.from('mood_tracker_reasons').select().eq('mood_tracker_id', moodTrackerId).execute();

    if (response.status! >= 200 && response.status! <= 299) {
      final moodReasonsMapData = response.data as List<Map<String, dynamic>>;

      final moodReasonsData = moodReasonsMapData.map((moodReason) {
        return MoodReason(id: moodReason['id'], moodTrackerId: moodReason['mood_tracker_id'], reason: moodReason['reason'],);
      }).toList();

      return moodReasonsData;
    }

    throw ErrorDescription(response.error!.message);
  }

  Future<List<RecomendedPlaylist>> getRecomendedPlaylist({required List<MoodReason> reasons, required int moodPoint}) async {
    final response = await client.from().select().execute();

    if (response.status! >= 200 && response.status! <= 299) {
      final playlistsMapData = response.data as List<Map<String, dynamic>>;

      final playlistsData = playlistsMapData.map((playlist) {
        return RecomendedPlaylist(
          id: playlist['id'], 
          name: , 
          createdAt: , 
          description2: , 
          quantity: , 
          topicId: , 
          roundedImage: , 
          squaredImage: ,
          );
      }).toList();

      return playlistsData;
    }

    throw ErrorDescription(response.error!.message);
  }

  Future<MoodTrackerDailyInsightModel> fetchDailyMoodInsight({
    required int userId,
  }) async {
    final response = await client.from().select().execute();

    if (response.status! >= 200 && response.status! <= 299) {
      final dailyMoodMapData = response.data as List<Map<String, dynamic>>;

      final dailyMoodData = MoodTrackerDailyInsightModel(
        isTodayFinished: ,
        mood: ,
        reasons: ,
        reccomendedPlaylists: ,
      );

      return dailyMoodData;
    }

    throw ErrorDescription(response.error!.message);
  }

  Future<MoodTrackerWeeklyInsightModel> fetchWeeklyMoodInsight({
    required int userId,
  }) async {
    final response = await client.from().select().execute();

    if (response.status! >= 200 && response.status! <= 299) {
      final weeklyMoodMapData = response.data as List<Map<String, dynamic>>;

      final weeklyMoodData = MoodTrackerWeeklyInsightModel(
        listAccReason: ,
        moodTrackers: ,
        sortedMood: ,
      );

      return weeklyMoodData;
    }

    throw ErrorDescription(response.error!.message);
  }

  Future<MoodTrackerPostResponse> postMoodTracker({
    required int userId,
    required int mood,
    required List<String> reasons,
  }) async {
    final response = await client.from().insert().execute();

    if (response.status! >= 200 && response.status! <= 299) {
      
    }
  }
}

final moodTrackerServiceSupa = MoodTrackerServiceSupa();
