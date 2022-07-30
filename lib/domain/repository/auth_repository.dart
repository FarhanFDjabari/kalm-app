import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/auth/login_entity.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, LoginEntity>> signIn({
    required String email,
    required String password,
  });

  Future<Either<String, UserEntity>> getUser({required int userId});

  Future<Either<String, UserEntity>> createUser({
    required String name,
    required String email,
    required String username,
    required String password,
    required String gender,
  });

  Future<bool> logout();
}
