import 'package:get_storage/get_storage.dart';
import 'package:kalm/data/sources/remote/services/auth/auth_service.dart';
import 'package:kalm/domain/entity/auth/login_entity.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthService service;

  AuthRepositoryImpl({required this.service});

  @override
  Future<LoginEntity> signIn(
      {required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> createUser(
      {required String name,
      required String email,
      required String username,
      required String password,
      required String gender}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> getUser({required int userId}) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() async {
    try {
      await GetStorage().remove("user_id");
      return true;
    } catch (e) {
      return false;
    }
  }
}
