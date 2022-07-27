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
  final User user;

  AuthLoadSuccess(this.user);
}

class AuthRegisterSuccess extends AuthState {
  final User user;

  AuthRegisterSuccess(this.user);
}

class AuthDeleted extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}
