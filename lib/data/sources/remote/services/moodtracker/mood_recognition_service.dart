import 'package:dio/dio.dart';
import 'package:kalm/data/sources/remote/interceptor/dio.dart';
import 'package:retrofit/http.dart';

part 'mood_recognition_service.g.dart';

@RestApi()
abstract class MoodRecognitionService {
  factory MoodRecognitionService(Dio dio, {String baseUrl}) =
      _MoodRecognitionService;

  static Future<MoodRecognitionService> create({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    final defHeader = Map<String, dynamic>.from(headers);
    // defHeader["Accept"] = "application/json";

    return MoodRecognitionService(
      await AppDio().getDIO(
          headers: defHeader,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout),
      baseUrl: "https://pure-gorge-89297.herokuapp.com/",
    );
  }

  @POST("mood/predict")
  Future<dynamic> getMoodRecognition(
      {@Body() required Map<String, String> body});
}

final moodRecognitionService = MoodRecognitionService.create;
