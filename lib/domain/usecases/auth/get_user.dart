import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/repository/auth_repository.dart';

class GetUser {
  final AuthRepository repository;

  GetUser({required this.repository});

  Future<Either<String, UserEntity>> execute({required String userId}) {
    return repository.getUser(userId: userId);
  }
}
