import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kalm/data/sources/local/hive_constants.dart';
import 'package:kalm/data/sources/local/hive_keys.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/auth/auth_service.supa.dart';
import 'package:kalm/domain/entity/auth/login_entity.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<String, LoginEntity>> signIn(
      {required String email, required String password}) async {
    try {
      final client = authServiceSupa;
      final result = await client
          .signInUserWithEmailAndPassword(email: email, password: password)
          .handleError((onError) {
        return Left(onError.toString());
      });

      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> createUser(
      {required String name,
      required String email,
      required String username,
      required String password,
      required String gender}) async {
    try {
      final client = authServiceSupa;
      final result = await client
          .createNewUser(
              email: email,
              password: password,
              name: name,
              username: username,
              jenisKelamin: gender)
          .handleError((onError) {
        return Left(onError.toString());
      });

      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> getUser({required int userId}) async {
    try {
      final client = authServiceSupa;
      final result = await client
          .getUserById(userId: userId)
          .handleError((onError) => Left(onError.toString()));

      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
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
      final client = authServiceSupa;

      final response = await client.signOut();
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        final storageBox = Hive.box<UserEntity>(HiveConstants.USERS);
        await storageBox.delete(HiveKeys.CURRENT_USER);
        await GetStorage().remove("user_id");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
