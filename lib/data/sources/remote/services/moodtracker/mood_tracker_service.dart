import 'package:dio/dio.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_daily_insight_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_home_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_post_response.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_weekly_insight_model.dart';
import 'package:kalm/data/sources/remote/interceptor/dio.dart';
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:kalm/data/sources/remote/wrapper/api_response.dart';
import 'package:retrofit/http.dart';

part 'mood_tracker_service.g.dart';

@RestApi()
abstract class MoodTrackerService {
  factory MoodTrackerService(Dio dio, {String baseUrl}) = _MoodTrackerService;

  static Future<MoodTrackerService> create({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    final defHeader = Map<String, dynamic>.from(headers);
    // defHeader["Accept"] = "application/json";

    return MoodTrackerService(
      await AppDio().getDIO(
          headers: defHeader,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout),
      baseUrl: ConfigEnvironments.getEnvironments().toString(),
    );
  }

  @GET('api/v1/mood-tracks/home')
  Future<ApiResponse<MoodTrackerHomeModel>> fetchHomeData(
      {@Query("user_id") required int userId});

  @POST('api/v1/mood-tracks/index-harian')
  Future<ApiResponse<MoodTrackerDailyInsightModel>> fetchDailyMoodInsight({
    @Body() required Map<String, dynamic> body,
  });

  @POST('api/v1/mood-tracks/index-mingguan')
  Future<ApiResponse<MoodTrackerWeeklyInsightModel>> fetchWeeklyMoodInsight({
    @Body() required Map<String, dynamic> body,
  });

  @POST('api/v1/mood-tracks')
  Future<ApiResponse<MoodTrackerPostResponse>> postMoodTracker({
    @Body() required Map<String, dynamic> body,
  });
}

final moodTrackerClient = MoodTrackerService.create;
