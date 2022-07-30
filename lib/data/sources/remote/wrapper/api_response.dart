import 'package:json_annotation/json_annotation.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class ApiResponse<T> {
  final T? data;
  final bool success;
  final int statusCode;
  final String message;

  ApiResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return ApiResponse<T>(
        success: json["success"] as bool,
        message: json["mesage"] as String,
        statusCode: json["statusCode"] as int,
        data: _Converter<T?>().fromJson(json["data"]));
  }
}

class _Converter<T> implements JsonConverter<T?, Object?> {
  const _Converter();

  @override
  T? fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      return ModelFactory.fromJson(T, json) as T;
    }
    return json as T;
  }

  @override
  Object toJson(T? object) {
    return (object as Object);
  }
}
