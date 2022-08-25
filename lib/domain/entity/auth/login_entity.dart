import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  const LoginEntity({
    this.userId,
  });

  final String? userId;

  @override
  List<Object?> get props => [userId];
}
