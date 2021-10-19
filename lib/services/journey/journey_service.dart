import 'package:dio/dio.dart';
import 'package:kalm/model/journey/journey_detail_model.dart';
import 'package:kalm/model/journey/journey_model.dart';
import 'package:kalm/model/journey/journey_task_model.dart';

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

  Future<JourneyTaskModel> getJourneyTask(int userId, int taskId) async {
    try {
      Response _response = await _dio.get(
          BASE_URL + 'api/v1/journeys/component/$taskId',
          queryParameters: {"user_id": userId});
      return JourneyTaskModel.fromJson(_response.data);
    } on DioError catch (error) {
      return JourneyTaskModel.fromJson(error.response?.data);
    }
  }
}
