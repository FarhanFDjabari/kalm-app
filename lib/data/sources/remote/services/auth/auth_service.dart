import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/data/model/auth/login.dart';
import 'package:kalm/data/model/auth/user_info.dart';
import 'package:kalm/data/sources/remote/interceptor/dio.dart';
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:kalm/data/sources/remote/wrapper/api_response.dart';
import 'package:retrofit/http.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  static Future<AuthService> create({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    final defHeader = Map<String, dynamic>.from(headers);
    // defHeader["Accept"] = "application/json";

    return AuthService(
      await AppDio().getDIO(
          headers: defHeader,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout),
      baseUrl: ConfigEnvironments.getEnvironments().toString(),
    );
  }

  @POST("api/v1/auth/login")
  Future<ApiResponse<Login>> signInUserWithEmailAndPassword({
    @Part(name: 'email') required String email,
    @Part(name: 'password') required String password,
  });

  @GET("api/v1/user/get_user")
  Future<ApiResponse<UserInfo>> getUserById(
      {@Part(name: 'user_id') required int userId});

  @POST("api/v1/auth/register")
  Future<ApiResponse<UserInfo>> createNewUser(
      {@Part(name: 'name') required String name,
      @Part(name: 'email') required String email,
      @Part(name: 'username') required String username,
      @Part(name: 'password') required String password,
      @Part(name: 'jenis_kelamin') required String jenisKelamin});
}

final authClient = AuthService.create;
