import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/auth/user_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class UserInfo extends Equatable implements ModelFactory {
  const UserInfo({
    this.user,
  });

  final User? user;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
      };

  @override
  List<Object?> get props => [user];
}
