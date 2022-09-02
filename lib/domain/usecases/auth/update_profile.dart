import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/auth/login_entity.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/repository/auth_repository.dart';

class UpdateProfile {
  final AuthRepository repository;

  UpdateProfile({required this.repository});

  Future<Either<String, UserEntity>> execute(
      {required int userId, String? username, File? profilePhoto}) {
    return repository.updateUserProfile(
      userId: userId,
      username: username,
      profilePhoto: profilePhoto,
    );
  }
}
