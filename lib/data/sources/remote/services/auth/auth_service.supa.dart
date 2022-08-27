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
    final response = await client.auth.signIn(email: email, password: password);
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      return Login(userId: int.tryParse(response.data?.user?.id ?? ""));
    }
    throw ErrorDescription(response.error!.message);
  }

  Future<userModel.User> getUserById({required int userId}) async {
    final response =
        await client.from('profiles').select().eq('id', userId).execute();

    if (response.status! >= 200 && response.status! <= 299) {
      // response data: [{id, email, name, username}]
      final userMapData = response.data as List<Map<String, dynamic>>;
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
  }

  Future<userModel.User> createNewUser(
      {required String name,
      required String email,
      required String username,
      required String password,
      required String jenisKelamin}) async {
    final userAuth = await client.auth.signUp(email, password);

    if (userAuth.statusCode! >= 200 && userAuth.statusCode! <= 299) {
      final insertProfile = await client.from('profiles').insert({
        'user_id': userAuth.data?.user?.id,
        'nama_lengkap': name,
        'jenis_kelamin': jenisKelamin,
        'username': username,
        'email': email,
        'role': 'user',
      }).execute();

      if (insertProfile.status! >= 200 && insertProfile.status! <= 299) {
        final userMapData = insertProfile.data as List<Map<String, dynamic>>;
        final userData = userModel.User(
          id: int.tryParse(userMapData.first['id']),
          email: userMapData.first['email'].toString(),
          jenisKelamin: userMapData.first['jenis_kelamin'].toString(),
          name: userMapData.first['nama_lengkap'].toString(),
          username: userMapData.first['username'].toString(),
        );
        return userData;
      }
      throw ErrorDescription(insertProfile.error!.message);
    } else {
      throw ErrorDescription(userAuth.error!.message);
    }
  }

  Future<GotrueResponse> signOut() async {
    return await client.auth.signOut();
  }
}

final authServiceSupa = AuthServiceSupa();
