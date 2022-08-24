// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curhat_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _CurhatService implements CurhatService {
  _CurhatService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<CurhatModel>> fetchAllCurhat({required userId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': userId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<CurhatModel>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'api/v1/curhatans',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<CurhatModel>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<CurhatModel>> fetchCurhatByCategory(
      {required category, required userId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': userId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<CurhatModel>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'api/v1/curhatans/category/${category}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<CurhatModel>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<DetailCurhatModel>> fetchCurhatById(
      {required userId, required curhatId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': userId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<DetailCurhatModel>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'api/v1/curhatans/${curhatId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<DetailCurhatModel>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<CreateCurhatanModel>> createNewCurhat(
      {required body}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<CreateCurhatanModel>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'api/v1/curhatans',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<CreateCurhatanModel>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<CommentModel>> createNewComment({required body}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<CommentModel>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'api/v1/comments',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<CommentModel>.fromJson(_result.data!);
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
