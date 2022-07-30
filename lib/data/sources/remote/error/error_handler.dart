import 'package:flutter/material.dart';
import 'package:kalm/data/sources/remote/wrapper/api_response.dart';

extension FutureAPIResultExt<T extends ApiResponse> on Future<T> {
  Future<T> validateStatus() {
    return then((value) async {
      final statusCode = value.statusCode;
      final message = value.message;
      // You can use this if has multiple domain url and separate the error
      final isSuccess = value.success;
      debugPrint("SUCCESS => $isSuccess");

      if (statusCode >= 200 && statusCode <= 299) return value;
      throw message;
    });
  }
}
