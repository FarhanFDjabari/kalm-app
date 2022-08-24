part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final int userId;

  AuthLoginSuccess(this.userId);
}

class AuthLoadSuccess extends AuthState {
  final UserEntity user;

  AuthLoadSuccess(this.user);
}

class AuthRegisterSuccess extends AuthState {
  final UserEntity user;

  AuthRegisterSuccess(this.user);
}

class AuthDeleted extends AuthState {}

class AuthSaveSuccess extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}
