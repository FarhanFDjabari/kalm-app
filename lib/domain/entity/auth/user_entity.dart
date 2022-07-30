import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
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

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        username,
        jenisKelamin,
      ];
}
