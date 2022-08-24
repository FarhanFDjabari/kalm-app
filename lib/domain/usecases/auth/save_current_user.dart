import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/repository/auth_repository.dart';

class SaveCurrentUser {
  final AuthRepository repository;

  SaveCurrentUser({required this.repository});

  Future<bool> execute({required UserEntity currentUser}) {
    return repository.saveCurrentUser(user: currentUser);
  }
}
