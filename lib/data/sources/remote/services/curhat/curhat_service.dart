import 'package:dio/dio.dart';
import 'package:kalm/data/model/curhat/comment_model.dart';
import 'package:kalm/data/model/curhat/create_curhat_model.dart';
import 'package:kalm/data/model/curhat/curhat_model.dart';
import 'package:kalm/data/model/curhat/detail_curhat_model.dart';
import 'package:kalm/data/sources/remote/interceptor/dio.dart';
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:kalm/data/sources/remote/wrapper/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'curhat_service.g.dart';

@RestApi()
abstract class CurhatService {
  factory CurhatService(Dio dio, {String baseUrl}) = _CurhatService;

  static Future<CurhatService> create({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    final defHeader = Map<String, dynamic>.from(headers);
    // defHeader["Accept"] = "application/json";

    return CurhatService(
      await AppDio().getDIO(
          headers: defHeader,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout),
      baseUrl: ConfigEnvironments.getEnvironments().toString(),
    );
  }

  @GET('api/v1/curhatans')
  Future<ApiResponse<CurhatModel>> fetchAllCurhat(
      {@Query("user_id") required int userId});

  @GET('api/v1/curhatans/category/{category}')
  Future<ApiResponse<CurhatModel>> fetchCurhatByCategory({
    @Path("category") required String category,
    @Query("user_id") required int userId,
  });

  @GET('api/v1/curhatans/{curhatId}')
  Future<ApiResponse<DetailCurhatModel>> fetchCurhatById({
    @Query("user_id") required int userId,
    @Path("curhatId") required int curhatId,
  });

  @POST('api/v1/curhatans')
  Future<ApiResponse<CreateCurhatanModel>> createNewCurhat({
    @Body() required Map<String, dynamic> body,
  });

  @POST('api/v1/comments')
  Future<ApiResponse<CommentModel>> createNewComment({
    @Body() required Map<String, dynamic> body,
  });
}

final curhatClient = CurhatService.create;
