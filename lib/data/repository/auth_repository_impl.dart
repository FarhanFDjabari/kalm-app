import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kalm/data/sources/local/database_helper.dart';
import 'package:kalm/data/sources/local/hive_constants.dart';
import 'package:kalm/data/sources/local/hive_keys.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/auth/auth_service.dart';
import 'package:kalm/domain/entity/auth/login_entity.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<String, LoginEntity>> signIn(
      {required String email, required String password}) async {
    try {
      final client = await authClient();
      final response = client.signInUserWithEmailAndPassword(
          email: email, password: password);
      final result = await response.validateStatus().handleError((onError) {
        return Left(onError.toString());
      });

      if (result.statusCode >= 200 && result.statusCode <= 299) {
        return Right(result.data!.toEntity());
      } else {
        return Left(result.message);
      }
    } catch (e) {
      return Left("Unknown Error");
    }
  }

  @override
  Future<Either<String, UserEntity>> createUser(
      {required String name,
      required String email,
      required String username,
      required String password,
      required String gender}) async {
    final client = await authClient();
    final response = client.createNewUser(
      name: name,
      email: email,
      username: username,
      password: password,
      jenisKelamin: gender,
    );
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });

    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.user!.toEntity());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, UserEntity>> getUser({required int userId}) async {
    final client = await authClient();
    final response = client.getUserById(userId: userId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.user!.toEntity());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<bool> saveCurrentUser({required UserEntity user}) async {
    try {
      final storageBox = Hive.box<UserEntity>(HiveConstants.USERS);
      await storageBox.put(HiveKeys.CURRENT_USER, user);

      return true;
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> getCurrentUser() async {
    try {
      final storageBox = Hive.box<UserEntity>(HiveConstants.USERS);
      final currentUser = storageBox.get(HiveKeys.CURRENT_USER);
      if (currentUser != null) {
        return Right(currentUser);
      } else {
        return Left('User data not found');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<bool> logout() async {
    try {
      final storageBox = Hive.box<UserEntity>(HiveConstants.USERS);
      await storageBox.delete(HiveKeys.CURRENT_USER);
      await GetStorage().remove("user_id");
      return true;
    } catch (e) {
      return false;
    }
  }
}
