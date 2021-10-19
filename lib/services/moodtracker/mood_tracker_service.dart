import 'package:dio/dio.dart';
import 'package:kalm/model/mood_tracker/mood_tracker_daily_response.dart';
import 'package:kalm/model/mood_tracker/mood_tracker_home_response.dart';
import 'package:kalm/model/mood_tracker/mood_tracker_post_response.dart';
import 'package:kalm/model/mood_tracker/mood_tracker_weekly_response.dart';

class MoodTrackerService {
  static MoodTrackerService? _service;

  MoodTrackerService._createObject();

  factory MoodTrackerService() =>
      _service ?? MoodTrackerService._createObject();

  Dio _dio = Dio();
  final String BASE_URL = "http://calma.com-indo.com/";

  Future<MoodTrackerHomeResponse> fetchHomeData(int userId) async {
    try {
      Response _response = await _dio.get(
        BASE_URL + 'api/v1/mood-tracks/home',
        queryParameters: {"user_id": userId},
      );
      MoodTrackerHomeResponse _moodTrackerData =
          MoodTrackerHomeResponse.fromJson(_response.data);
      return _moodTrackerData;
    } on DioError catch (error) {
      return MoodTrackerHomeResponse.fromJson(error.response?.data!);
    }
  }

  Future<MoodTrackerDailyResponse> fetchDailyMoodInsight(int userId) async {
    try {
      Response _response = await _dio.post(
        BASE_URL + 'api/v1/mood-tracks/index-harian',
        data: {"user_id": userId},
      );
      MoodTrackerDailyResponse _moodTrackerData =
          MoodTrackerDailyResponse.fromJson(_response.data);
      return _moodTrackerData;
    } on DioError catch (error) {
      return MoodTrackerDailyResponse.fromJson(error.response?.data!);
    }
  }

  Future<MoodTrackerWeeklyResponse> fetchWeeklyMoodInsight(int userId) async {
    try {
      Response _response = await _dio.post(
        BASE_URL + 'api/v1/mood-tracks/index-mingguan',
        data: {"user_id": userId},
      );
      MoodTrackerWeeklyResponse _moodTrackerData =
          MoodTrackerWeeklyResponse.fromJson(_response.data);
      return _moodTrackerData;
    } on DioError catch (error) {
      return MoodTrackerWeeklyResponse.fromJson(error.response?.data!);
    }
  }

  Future<MoodTrackerPostResponse> postMoodTracker(
      int userId, int mood, List<String> reasons) async {
    try {
      Response _response = await _dio.post(
        BASE_URL + 'api/v1/mood-tracks',
        data: {"user_id": userId, "mood": mood, "reasons": reasons},
      );
      MoodTrackerPostResponse _moodTrackerData =
          MoodTrackerPostResponse.fromJson(_response.data);
      return _moodTrackerData;
    } on DioError catch (error) {
      return MoodTrackerPostResponse.fromJson(error.response?.data!);
    }
  }
}
