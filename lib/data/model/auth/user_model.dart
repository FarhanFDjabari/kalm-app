import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';

class User extends Equatable implements ModelFactory {
  const User({
    this.id,
    this.name,
    this.email,
    this.username,
    this.jenisKelamin,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? username;
  final String? jenisKelamin;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        jenisKelamin: json["jenis_kelamin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "jenis_kelamin": jenisKelamin,
      };

  UserEntity toEntity() {
    return UserEntity(
      id: id.toString(),
      email: email,
      name: name,
      username: username,
      jenisKelamin: jenisKelamin,
    );
  }

  @override
  List<Object?> get props => [id, name, email, username, jenisKelamin];
}
