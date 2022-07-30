import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  const LoginEntity({
    this.userId,
  });

  final int? userId;

  @override
  List<Object?> get props => [userId];
}
