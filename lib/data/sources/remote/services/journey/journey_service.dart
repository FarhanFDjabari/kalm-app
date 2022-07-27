import 'package:dio/dio.dart';
import 'package:kalm/data/model/journey/journal_quote_response.dart';
import 'package:kalm/data/model/journey/journal_task_model.dart';
import 'package:kalm/data/model/journey/journey_detail_model.dart';
import 'package:kalm/data/model/journey/journey_model.dart';
import 'package:kalm/data/model/journey/journey_post_response.dart';
import 'package:kalm/data/model/journey/meditation_task_model.dart';

class JourneyService {
  static JourneyService? _service;

  JourneyService._createObject();

  factory JourneyService() => _service ?? JourneyService._createObject();
  Dio _dio = Dio();
  final String BASE_URL = "http://calma.com-indo.com/";

  Future<JourneyModel> fetchAllJourney(int userId) async {
    try {
      Response _response = await _dio.get(BASE_URL + 'api/v1/journeys',
          queryParameters: {'user_id': userId});
      JourneyModel journeyData = JourneyModel.fromJson(_response.data);
      return journeyData;
    } on DioError catch (error) {
      return JourneyModel.fromJson(error.response!.data);
    }
  }

  Future<JourneyDetailModel> getJourneyById(int journeyId, int userId) async {
    try {
      Response _response = await _dio.get(
          BASE_URL + 'api/v1/journeys/$journeyId',
          queryParameters: {"user_id": userId});
      return JourneyDetailModel.fromJson(_response.data);
    } on DioError catch (error) {
      return JourneyDetailModel.fromJson(error.response?.data);
    }
  }

  Future<JournalTaskModel> getJournalTask(int userId, int taskId) async {
    try {
      Response _response = await _dio.get(
          BASE_URL + 'api/v1/journeys/component/$taskId',
          queryParameters: {"user_id": userId});
      return JournalTaskModel.fromJson(_response.data);
    } on DioError catch (error) {
      return JournalTaskModel.fromJson(error.response?.data);
    }
  }

  Future<JourneyPostResponse> postJournalTask(
      int userId, int componentId, int journeyId, List answers) async {
    try {
      Response _response = await _dio
          .post(BASE_URL + 'api/v1/journeys/journal-submission', data: {
        "user_id": userId,
        "journey_component_id": componentId,
        "journey_id": journeyId,
        "answers": answers
      });
      return JourneyPostResponse.fromJson(_response.data);
    } on DioError catch (error) {
      return JourneyPostResponse.fromJson(error.response?.data);
    }
  }

  Future<JourneyQuoteResponse> getJourneyQuote(
      int userId, int journeyId) async {
    try {
      Response _response = await _dio.get(BASE_URL + 'api/v1/quotes/$journeyId',
          queryParameters: {"user_id": userId});
      return JourneyQuoteResponse.fromJson(_response.data);
    } on DioError catch (error) {
      return JourneyQuoteResponse.fromJson(error.response?.data);
    }
  }

  Future<MeditationTaskModel> getMeditationTask(int userId, int taskId) async {
    try {
      Response _response = await _dio.get(
          BASE_URL + 'api/v1/journeys/component/$taskId',
          queryParameters: {"user_id": userId});
      return MeditationTaskModel.fromJson(_response.data);
    } on DioError catch (error) {
      return MeditationTaskModel.fromJson(error.response?.data);
    }
  }

  Future<JourneyPostResponse> postMeditationTask(
      int userId, int componentId, int journeyId) async {
    try {
      Response _response = await _dio
          .post(BASE_URL + 'api/v1/journeys/music-submission', data: {
        "user_id": userId,
        "journey_component_id": componentId,
        "journey_id": journeyId
      });
      return JourneyPostResponse.fromJson(_response.data);
    } on DioError catch (error) {
      return JourneyPostResponse.fromJson(error.response?.data);
    }
  }
}
