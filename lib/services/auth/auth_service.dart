import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/model/auth/login_response.dart';
import 'package:kalm/model/auth/register_response.dart';
import 'package:kalm/model/auth/user_info_response.dart';

class AuthService {
  static AuthService? _service;

  AuthService._createObject();

  factory AuthService() => _service ?? AuthService._createObject();

  Dio _dio = Dio();
  static String BASE_URL = "http://calma.com-indo.com/";

  Future<LoginResponse> signInUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      Response _response = await _dio.post(BASE_URL + 'api/v1/auth/login',
          data: {"email": email, "password": password});
      LoginResponse _loginResponse = LoginResponse.fromJson(_response.data);
      return _loginResponse;
    } on DioError catch (error) {
      LoginResponse _errorLoginResponse =
          LoginResponse.fromJson(error.response?.data);
      return _errorLoginResponse;
    }
  }

  Future<UserInfoResponse> getUserById({required int userId}) async {
    try {
      Response _response = await _dio
          .post(BASE_URL + 'api/v1/user/get_user', data: {"user_id": userId});
      UserInfoResponse _userInfoResponse =
          UserInfoResponse.fromJson(_response.data);
      return _userInfoResponse;
    } on DioError catch (error) {
      UserInfoResponse _errorUserInfoResponse =
          UserInfoResponse.fromJson(error.response?.data);
      return _errorUserInfoResponse;
    }
  }

  Future<RegisterResponse> createNewUser(
      {required String name,
      required String email,
      required String password,
      required String jenisKelamin}) async {
    try {
      Response _response = await _dio.post(
        BASE_URL + 'api/v1/auth/register',
        data: {
          "name": name,
          "email": email,
          "password": password,
          "username": email,
          "jenis_kelamin": jenisKelamin
        },
      );
      final _result = _response.data;

      return RegisterResponse.fromJson(_result);
    } on DioError catch (error) {
      return RegisterResponse.fromJson(error.response?.data);
    }
  }

  Future<bool> logout() async {
    try {
      await GetStorage().remove("user_id");
      return true;
    } catch (e) {
      return false;
    }
  }
}
