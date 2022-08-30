import 'package:flutter/foundation.dart';
import 'package:kalm/data/model/auth/login.dart';
import 'package:kalm/data/model/auth/user_model.dart' as userModel;
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:supabase/supabase.dart';

class AuthServiceSupa {
  final client = SupabaseClient(
      ConfigEnvironments.getEnvironments(), ConfigEnvironments.getPublicKey());

  Future<Login> signInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await client.auth.signIn(email: email, password: password);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return Login(userId: int.tryParse(response.data?.user?.id ?? ""));
      }
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }

  Future<userModel.User> getUserById({required int userId}) async {
    try {
      final response =
          await client.from('profiles').select().eq('id', userId).execute();

      if (response.status! >= 200 && response.status! <= 299) {
        // response data: [{id, email, name, username}]
        final userMapData = response.data as List<dynamic>;
        final userData = userModel.User(
          id: int.tryParse(userMapData.first['id']),
          email: userMapData.first['email'].toString(),
          jenisKelamin: userMapData.first['jenis_kelamin'].toString(),
          name: userMapData.first['nama_lengkap'].toString(),
          username: userMapData.first['username'].toString(),
        );

        return userData;
      }
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }

  Future<userModel.User> createNewUser(
      {required String name,
      required String email,
      required String username,
      required String password,
      required String jenisKelamin}) async {
    try {
      final userAuth = await client.auth.signUp(email, password);

      if (userAuth.statusCode! >= 200 && userAuth.statusCode! <= 299) {
        final insertProfile = await client.from('profiles').insert({
          'user_id': userAuth.user?.id,
          'nama_lengkap': name,
          'jenis_kelamin': jenisKelamin,
          'username': username,
          'email': userAuth.user?.email,
          'role': 'user',
          'profile_image': ''
        }).execute();

        if (insertProfile.status! >= 200 && insertProfile.status! <= 299) {
          print(insertProfile.data);
          final userMapData = insertProfile.data as List<dynamic>;
          final userData = userModel.User(
            id: userMapData.first['id'] as int,
            email: userMapData.first['email'].toString(),
            jenisKelamin: userMapData.first['jenis_kelamin'].toString(),
            name: userMapData.first['nama_lengkap'].toString(),
            username: userMapData.first['username'].toString(),
          );
          return userData;
        }
        print(insertProfile.error!.message);
        throw ErrorDescription(insertProfile.error!.message);
      } else {
        throw ErrorDescription(userAuth.error!.message);
      }
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<GotrueResponse> signOut() async {
    return await client.auth.signOut();
  }
}

final authServiceSupa = AuthServiceSupa();
