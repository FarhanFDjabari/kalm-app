import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/repository/auth_repository.dart';

class GetUser {
  final AuthRepository repository;

  GetUser({required this.repository});

  Future<UserEntity> execute({required int userId}) {
    return repository.getUser(userId: userId);
  }
}
