import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/model/auth/user_model.dart';
import 'package:kalm/services/auth/auth_service.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthService authService = AuthService();

  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await authService.signInUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.success == true) {
        GetStorage().write("user_id", result.data!.userId);
        emit(AuthLoginSuccess(result.data!.userId!));
      } else
        emit(AuthError('Login error: \n${result.message}'));
    } catch (error) {
      emit(AuthError('Login error: \n$error'));
    }
  }

  void register(
      String email, String password, String name, String jenisKelamin) async {
    emit(AuthLoading());
    try {
      final result = await authService.createNewUser(
          email: email,
          password: password,
          name: name,
          jenisKelamin: jenisKelamin);
      if (result.success == true) {
        GetStorage().write("user_id", result.data!.user!.id!);
        emit(AuthRegisterSuccess(result.data!.user!));
      } else
        emit(AuthError('Register error: \nemail or password incorrect'));
    } catch (error) {
      emit(AuthError('Register error: \n$error'));
    }
  }

  void getUserInfo(int userId) async {
    emit(AuthLoading());
    try {
      final result = await authService.getUserById(userId: userId);
      if (result.success == true)
        emit(AuthLoadSuccess(result.data!.user!));
      else
        emit(AuthError('Auth error: \nemail or password incorrect'));
    } catch (error) {
      emit(AuthError('Auth error: \n$error'));
    }
  }

  void logout() async {
    emit(AuthLoading());
    try {
      final result = await authService.logout();
      if (result == true)
        emit(AuthDeleted());
      else
        emit(AuthError('Auth error: \nemail or password incorrect'));
    } catch (error) {
      emit(AuthError('Auth error: \n$error'));
    }
  }
}
