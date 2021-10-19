import 'package:dio/dio.dart';
import 'package:kalm/model/curhat/comment_model.dart';
import 'package:kalm/model/curhat/create_curhat_response.dart';
import 'package:kalm/model/curhat/curhat_model.dart';
import 'package:kalm/model/curhat/detail_curhat_model.dart';

class CurhatService {
  static CurhatService? _service;

  CurhatService._createObject();

  factory CurhatService() => _service ?? CurhatService._createObject();

  Dio _dio = Dio();
  final BASE_URL = 'http://calma.com-indo.com/';

  Future<CurhatModel> fetchAllCurhat({required int userId}) async {
    try {
      Response _response = await _dio.get(
        BASE_URL + 'api/v1/curhatans',
        queryParameters: {"user_id": userId},
      );
      CurhatModel _curhatModel = CurhatModel.fromJson(_response.data);
      return _curhatModel;
    } on DioError catch (error) {
      CurhatModel _error = CurhatModel.fromJson(error.response?.data);
      return _error;
    }
  }

  Future<CurhatModel> fetchCurhatByCategory(
      {required int userId, required String category}) async {
    try {
      Response _response = await _dio.get(
        BASE_URL + 'api/v1/curhatans/category/$category',
        queryParameters: {"user_id": userId},
      );
      CurhatModel _curhatModel = CurhatModel.fromJson(_response.data);
      return _curhatModel;
    } on DioError catch (error) {
      CurhatModel _error = CurhatModel.fromJson(error.response?.data);
      return _error;
    }
  }

  Future<DetailCurhatModel> fetchCurhatById(
      {required int userId, required int curhatId}) async {
    try {
      Response _response = await _dio.get(
        BASE_URL + 'api/v1/curhatans/$curhatId',
        queryParameters: {"user_id": userId},
      );
      DetailCurhatModel _detailCurhat =
          DetailCurhatModel.fromJson(_response.data);
      return _detailCurhat;
    } on DioError catch (error) {
      DetailCurhatModel _error =
          DetailCurhatModel.fromJson(error.response?.data);
      return _error;
    }
  }

  Future<CreateCurhatResponse> createNewCurhat(
      {required int userId,
      required bool isAnonymous,
      required String content,
      required String topic}) async {
    try {
      Response _response = await _dio.post(
        BASE_URL + 'api/v1/curhatans',
        data: {
          "user_id": userId,
          "is_anonymous": isAnonymous,
          "content": content,
          "topic": topic
        },
      );
      final result = CreateCurhatResponse.fromJson(_response.data);
      return result;
    } on DioError catch (error) {
      final errorData = CreateCurhatResponse.fromJson(error.response?.data);
      return errorData;
    }
  }

  Future<CommentModel> createNewComment(
      {required int userId,
      required int curhatId,
      required String content,
      required isAnonymous}) async {
    try {
      Response _response = await _dio.post(
        BASE_URL + 'api/v1/comments',
        data: {
          "user_id": userId,
          "curhatan_id": curhatId,
          "content": content,
          "is_anonymous": isAnonymous
        },
      );
      final result = CommentModel.fromJson(_response.data);
      return result;
    } on DioError catch (error) {
      final errorData = CommentModel.fromJson(error.response?.data);
      return errorData;
    }
  }
}
