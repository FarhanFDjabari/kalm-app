import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kalm/data/sources/local/hive_constants.dart';
import 'package:kalm/data/sources/local/hive_keys.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/auth/auth_service.dart';
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:kalm/domain/entity/auth/login_entity.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/repository/auth_repository.dart';
import 'package:supabase/supabase.dart';

class AuthRepositoryImpl extends AuthRepository {
  final client = SupabaseClient(
      ConfigEnvironments.getEnvironments(), ConfigEnvironments.getPublicKey());

  @override
  Future<Either<String, LoginEntity>> signIn(
      {required String email, required String password}) async {
    try {
      // final client = await authClient();
      final response = await client.auth
          .signIn(email: email, password: password)
          .handleError((onError) {
        return Left(onError.toString());
      });
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return Right(LoginEntity(userId: response.data?.user?.id));
      } else {
        return Left(response.error!.message);
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
    // final client = await authClient();
    final response =
        await client.auth.signUp(email, password).handleError((onError) {
      return Left(onError.toString());
    });

    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      final result = await client.from('profiles').insert({
        'user_id': response.data!.user!.id,
        'nama_lengkap': name,
        'jenis_kelamin': gender,
        'username': username,
        'email': email,
        'role': 'user',
      }).execute();

      if (result.status! >= 200 && result.status! <= 299) {
        final userData = UserEntity(
          id: response.data!.user!.id,
          email: email,
          jenisKelamin: gender,
          name: name,
          username: username,
        );
        return Right(userData);
      } else {
        return Left(result.error!.message);
      }
    } else {
      return Left(response.error!.message);
    }
  }

  @override
  Future<Either<String, UserEntity>> getUser({required String userId}) async {
    // final client = await authClient();
    final response = await client
        .from('profiles')
        .select()
        .eq('id', userId)
        .execute()
        .handleError((onError) {
      return Left(onError.toString());
    });
    if (response.status! >= 200 && response.status! <= 299) {
      // response data: [{id, email, name, username}]

      final userData = UserEntity(
        id: response.data[0].val('id'),
        email: response.data[0].val('email'),
        name: response.data[0].val('nama_lengkap'),
        username: response.data[0].val('username'),
        jenisKelamin: response.data[0].val('jenis_kelamin'),
      );
      return Right(userData);
    } else {
      return Left(response.error!.message);
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
      final response = await client.auth.signOut();
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
