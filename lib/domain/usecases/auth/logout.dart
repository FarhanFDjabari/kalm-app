import 'package:kalm/domain/repository/auth_repository.dart';

class Logout {
  final AuthRepository repository;

  Logout({required this.repository});

  Future<bool> execute() {
    return repository.logout();
  }
}
