import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/usecases/auth/create_user.dart';
import 'package:kalm/domain/usecases/auth/get_user.dart';
import 'package:kalm/domain/usecases/auth/logout.dart';
import 'package:kalm/domain/usecases/auth/sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.createUser,
    required this.getUser,
    required this.signOut,
    required this.signIn,
  }) : super(AuthInitial());

  final CreateUser createUser;
  final GetUser getUser;
  final Logout signOut;
  final SignIn signIn;

  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await signIn.execute(
        email: email,
        password: password,
      );
      result.fold(
        (l) => emit(AuthError('Login error: \n$l')),
        (r) {
          GetStorage().write("user_id", r.userId);
          emit(AuthLoginSuccess(r.userId!));
        },
      );
    } catch (error) {
      emit(AuthError('Login error: \n$error'));
    }
  }

  void register(
      String email, String password, String name, String jenisKelamin) async {
    emit(AuthLoading());
    try {
      final result = await createUser.execute(
          email: email,
          password: password,
          name: name,
          username: name,
          gender: jenisKelamin);
      result.fold(
        (l) => emit(AuthError('Register error: \n$l')),
        (r) {
          GetStorage().write("user_id", r.id);
          emit(AuthRegisterSuccess(r));
        },
      );
    } catch (error) {
      emit(AuthError('Register error: \n$error'));
    }
  }

  void getUserInfo(int userId) async {
    emit(AuthLoading());
    try {
      final result = await getUser.execute(userId: userId);
      result.fold(
        (l) => emit(AuthError('Auth error: \n$l')),
        (r) => emit(AuthLoadSuccess(r)),
      );
    } catch (error) {
      emit(AuthError('Auth error: \n$error'));
    }
  }

  void logout() async {
    emit(AuthLoading());
    try {
      final result = await signOut.execute();
      if (result == true)
        emit(AuthDeleted());
      else
        emit(AuthError('Auth error: \nemail or password incorrect'));
    } catch (error) {
      emit(AuthError('Auth error: \n$error'));
    }
  }
}
