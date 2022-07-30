import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/auth/auth_service.dart';
import 'package:kalm/domain/entity/auth/login_entity.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthService service;

  AuthRepositoryImpl({required this.service});

  @override
  Future<Either<String, LoginEntity>> signIn(
      {required String email, required String password}) async {
    await service
        .signInUserWithEmailAndPassword(email: email, password: password)
        .validateStatus()
        .then((response) {
      return Right(response.data!.toEntity());
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, UserEntity>> createUser(
      {required String name,
      required String email,
      required String username,
      required String password,
      required String gender}) async {
    await service
        .createNewUser(
          name: name,
          email: email,
          username: username,
          password: password,
          jenisKelamin: gender,
        )
        .validateStatus()
        .then((response) {
      return Right(response.data!.user!.toEntity());
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, UserEntity>> getUser({required int userId}) async {
    await service.getUserById(userId: userId).validateStatus().then((response) {
      return Right(response.data!.user!.toEntity());
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
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
