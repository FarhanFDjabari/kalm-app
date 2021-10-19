import 'package:kalm/model/auth/user_model.dart';

class RegisterResponse {
  RegisterResponse({
    this.success,
    this.statusCode,
    this.mesage,
    this.data,
  });

  bool? success;
  int? statusCode;
  String? mesage;
  Data? data;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        success: json["success"],
        statusCode: json["statusCode"],
        mesage: json["mesage"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "mesage": mesage,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.user,
  });

  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
      };
}
