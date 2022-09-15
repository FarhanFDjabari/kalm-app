import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';

class User extends Equatable implements ModelFactory {
  const User({
    this.id,
    this.uuid,
    this.name,
    this.email,
    this.username,
    this.jenisKelamin,
    this.photoProfileUrl,
  });

  final int? id;
  final String? uuid;
  final String? name;
  final String? email;
  final String? username;
  final String? jenisKelamin;
  final String? photoProfileUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        jenisKelamin: json["jenis_kelamin"],
        photoProfileUrl: json['photo_profile'],
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
      id: id,
      email: email,
      name: name,
      username: username,
      jenisKelamin: jenisKelamin,
      photoProfileUrl: photoProfileUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        uuid,
        name,
        email,
        username,
        jenisKelamin,
        photoProfileUrl,
      ];
}
