import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/repository/auth_repository.dart';

class CreateUser {
  final AuthRepository repository;

  CreateUser({required this.repository});

  Future<Either<String, UserEntity>> execute({
    required String name,
    required String email,
    required String username,
    required String password,
    required String gender,
  }) {
    return repository.createUser(
        name: name,
        email: email,
        username: username,
        password: password,
        gender: gender);
  }
}
