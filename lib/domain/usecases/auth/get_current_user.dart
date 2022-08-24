import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/repository/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser({required this.repository});

  Future<Either<String, UserEntity>> execute() {
    return repository.getCurrentUser();
  }
}
