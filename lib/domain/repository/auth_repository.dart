import 'package:kalm/domain/entity/auth/login_entity.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';

abstract class AuthRepository {
  Future<LoginEntity> signIn({
    required String email,
    required String password,
  });

  Future<UserEntity> getUser({required int userId});

  Future<UserEntity> createUser({
    required String name,
    required String email,
    required String username,
    required String password,
    required String gender,
  });

  Future<bool> logout();
}
