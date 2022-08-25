import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/usecases/auth/create_user.dart';
import 'package:kalm/domain/usecases/auth/get_current_user.dart';
import 'package:kalm/domain/usecases/auth/get_user.dart';
import 'package:kalm/domain/usecases/auth/logout.dart';
import 'package:kalm/domain/usecases/auth/save_current_user.dart';
import 'package:kalm/domain/usecases/auth/sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.createUser,
    required this.getUser,
    required this.signOut,
    required this.signIn,
    required this.getCurrentUserUsecase,
    required this.saveCurrentUserUsecase,
  }) : super(AuthInitial());

  final CreateUser createUser;
  final GetUser getUser;
  final Logout signOut;
  final SignIn signIn;
  final SaveCurrentUser saveCurrentUserUsecase;
  final GetCurrentUser getCurrentUserUsecase;

  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await signIn.execute(email: email, password: password);
      result.fold(
        (l) => emit(AuthError('Login error: $l')),
        (r) async {
          getUserInfo(r.userId ?? "0");
          // emit(AuthLoginSuccess(r.userId ?? 0));
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
        (r) async {
          saveCurrentUser(r);
          // emit(AuthRegisterSuccess(r));
        },
      );
    } catch (error) {
      emit(AuthError('Register error: \n$error'));
    }
  }

  void getUserInfo(String userId) async {
    emit(AuthLoading());
    try {
      final result = await getUser.execute(userId: userId);
      result.fold(
        (l) => emit(AuthError('Auth error: \n$l')),
        (r) {
          saveCurrentUser(r);
          // emit(AuthLoadSuccess(r));
        },
      );
    } catch (error) {
      emit(AuthError('Auth error: \n$error'));
    }
  }

  void getCurrentUser() async {
    emit(AuthLoading());
    try {
      final result = await getCurrentUserUsecase.execute();
      result.fold(
        (l) => emit(AuthError('$l')),
        (r) => emit(AuthLoadSuccess(r)),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> saveCurrentUser(UserEntity user) async {
    emit(AuthLoading());
    try {
      final result = await saveCurrentUserUsecase.execute(currentUser: user);
      if (result) {
        await GetStorage().write("user_id", user.id);
        emit(AuthSaveSuccess());
      } else {
        emit(AuthError('Error when saving current user'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
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
