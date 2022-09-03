import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/data/model/auth/login.dart';
import 'package:kalm/data/model/auth/user_model.dart' as userModel;
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServiceSupa {
  final client = Supabase.instance.client;

  Future<userModel.User> signInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await client.auth.signIn(email: email, password: password);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        final profileData = await client
            .from('profiles')
            .select('id, nama_lengkap, username, jenis_kelamin, profile_image')
            .eq('user_id', response.user?.id)
            .execute();

        if (profileData.hasError)
          throw ErrorDescription(profileData.error!.message);

        final userProfile = profileData.data as List<dynamic>;

        return userModel.User(
          id: int.tryParse(userProfile.first['id'].toString()),
          email: response.user?.email,
          name: userProfile.first['nama_lengkap'] as String?,
          username: userProfile.first['username'] as String?,
          jenisKelamin: userProfile.first['jenis_kelamin'] as String?,
          uuid: response.user?.id,
          photoProfileUrl: userProfile.first['profile_image'] as String?,
        );
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
          id: int.tryParse(userMapData.first['id'].toString()),
          email: userMapData.first['email'].toString(),
          jenisKelamin: userMapData.first['jenis_kelamin'].toString(),
          name: userMapData.first['nama_lengkap'].toString(),
          username: userMapData.first['username'].toString(),
          photoProfileUrl: userMapData.first['profile_image'].toString(),
          uuid: userMapData.first['user_id'].toString(),
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
          'created_at': userAuth.user?.createdAt,
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

  Future<Session?> checkSession() async {
    try {
      final response = client.auth.session();
      return response;
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }

  Future<userModel.User> updateProfile({
    required int userId,
    String? username,
    File? profilePhoto,
  }) async {
    try {
      if (profilePhoto != null) {
        final fileName = profilePhoto.uri.pathSegments.last;
        final storageList = await client.storage
            .from('images')
            .list(path: 'user_images/$userId');
        final filesToRemove = storageList.data
            ?.map((e) => 'user_images/$userId/${e.name}')
            .toList();
        await client.storage.from('images').remove(filesToRemove ?? []);

        final uploadProfilePhotoResponse =
            await client.storage.from('images').upload(
                  'user_images/$userId/$fileName',
                  profilePhoto,
                );

        if (uploadProfilePhotoResponse.hasError)
          throw ErrorDescription(uploadProfilePhotoResponse.error!.message);
        final profilePhotoUrlData = client.storage
            .from('images')
            .getPublicUrl('user_images/$userId/$fileName');

        if (profilePhotoUrlData.hasError)
          throw ErrorDescription(profilePhotoUrlData.error!.message);

        final response = await client
            .from('profiles')
            .update({
              username != null ? 'username' : username: "",
              'profile_image': profilePhotoUrlData.data,
            })
            .eq('id', userId)
            .execute();

        if (response.hasError) {
          print(response.error!.message);
          throw ErrorDescription(response.error!.message);
        }

        final userData = response.data as List<dynamic>;

        return userModel.User(
          id: userData.first['id'],
          email: userData.first['email'],
          jenisKelamin: userData.first['jenis_kelamin'],
          name: userData.first['nama_lengkap'],
          username: userData.first['username'],
          photoProfileUrl: userData.first['profile_image'],
          uuid: userData.first['user_id'],
        );
      }

      final response = await client
          .from('profiles')
          .update({
            'username': username,
          })
          .eq('id', userId)
          .execute();

      if (response.hasError) throw ErrorDescription(response.error!.message);

      final userData = response.data as List<dynamic>;

      return userModel.User(
        id: userData.first['id'],
        email: userData.first['email'],
        jenisKelamin: userData.first['jenis_kelamin'],
        name: userData.first['nama_lengkap'],
        username: userData.first['username'],
        photoProfileUrl: userData.first['profile_image'],
        uuid: userData.first['user_id'],
      );
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }

  Future<GotrueResponse> signOut() async {
    try {
      final response = await client.auth.signOut();
      return response;
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }
}

final authServiceSupa = AuthServiceSupa();
