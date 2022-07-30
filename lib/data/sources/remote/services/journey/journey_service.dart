import 'package:dio/dio.dart';
import 'package:kalm/data/model/journey/journal_quote_model.dart';
import 'package:kalm/data/model/journey/journal_task_model.dart';
import 'package:kalm/data/model/journey/journey_detail_model.dart';
import 'package:kalm/data/model/journey/journey_model.dart';
import 'package:kalm/data/model/journey/meditation_task_model.dart';
import 'package:kalm/data/sources/remote/interceptor/dio.dart';
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:kalm/data/sources/remote/wrapper/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'journey_service.g.dart';

@RestApi()
abstract class JourneyService {
  factory JourneyService(Dio dio, {String baseUrl}) = _JourneyService;

  static Future<JourneyService> create({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    final defHeader = Map<String, dynamic>.from(headers);
    // defHeader["Accept"] = "application/json";

    return JourneyService(
      await AppDio().getDIO(
          headers: defHeader,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout),
      baseUrl: ConfigEnvironments.getEnvironments().toString(),
    );
  }

  @GET('api/v1/journeys')
  Future<ApiResponse<JourneyModel>> fetchAllJourney({
    @Query("user_id") required int userId,
  });

  @GET('api/v1/journeys/{journeyId}')
  Future<ApiResponse<JourneyDetailModel>> getJourneyById({
    @Path("journeyId") required int journeyId,
    @Query("user_id") required int userId,
  });

  @GET('api/v1/journeys/component/{taskId}')
  Future<ApiResponse<JournalTaskModel>> getJournalTask({
    @Query("user_id") required int userId,
    @Path("taskId") required int taskId,
  });

  @FormUrlEncoded()
  @POST('api/v1/journeys/journal-submission')
  Future<ApiResponse> postJournalTask({
    @Field("user_id") required int userId,
    @Field("journey_component_id") required int componentId,
    @Field("journey_id") required int journeyId,
    @Field("answers[]") required List<Map<String, dynamic>> answers,
  });

  @GET('api/v1/quotes/{journeyId}')
  Future<ApiResponse<JournalQuoteModel>> getJourneyQuote({
    @Query("user_id") required int userId,
    @Path("journeyId") required int journeyId,
  });

  @GET('api/v1/journeys/component/{taskId}')
  Future<ApiResponse<MeditationTaskModel>> getMeditationTask({
    @Query("user_id") required int userId,
    @Path("taskId") required int taskId,
  });

  @POST('api/v1/journeys/music-submission')
  Future<ApiResponse> postMeditationTask({
    @Part(name: "user_id") required int userId,
    @Part(name: "journey_component_id") required int componentId,
    @Part(name: "journey_id") required int journeyId,
  });
}

final journeyClient = JourneyService.create;
