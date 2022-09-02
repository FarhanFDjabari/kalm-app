import 'package:kalm/domain/repository/auth_repository.dart';
import 'package:supabase/supabase.dart';

class CheckSession {
  final AuthRepository repository;

  CheckSession({required this.repository});

  Future<Session?> execute() {
    return repository.checkSession();
  }
}
