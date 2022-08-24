// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _AuthService implements AuthService {
  _AuthService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<Login>> signInUserWithEmailAndPassword(
      {required email, required password}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('email', email));
    _data.fields.add(MapEntry('password', password));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<Login>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'api/v1/auth/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<Login>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<UserInfo>> getUserById({required userId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('user_id', userId.toString()));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<UserInfo>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'api/v1/user/get_user',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<UserInfo>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<UserInfo>> createNewUser(
      {required name,
      required email,
      required username,
      required password,
      required jenisKelamin}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('name', name));
    _data.fields.add(MapEntry('email', email));
    _data.fields.add(MapEntry('username', username));
    _data.fields.add(MapEntry('password', password));
    _data.fields.add(MapEntry('jenis_kelamin', jenisKelamin));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<UserInfo>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'api/v1/auth/register',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<UserInfo>.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
