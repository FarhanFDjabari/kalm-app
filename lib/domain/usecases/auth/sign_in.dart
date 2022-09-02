import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/auth/login_entity.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/repository/auth_repository.dart';

class SignIn {
  final AuthRepository repository;

  SignIn({required this.repository});

  Future<Either<String, UserEntity>> execute(
      {required String email, required String password}) {
    return repository.signIn(email: email, password: password);
  }
}
