import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/auth/login_entity.dart';

class Login extends Equatable implements ModelFactory {
  const Login({
    this.userId,
  });

  final int? userId;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
      };

  LoginEntity toEntity() {
    return LoginEntity(userId: userId);
  }

  @override
  List<Object?> get props => [userId];
}
