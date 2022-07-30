import 'package:equatable/equatable.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';

class CurhatanEntity extends Equatable {
  const CurhatanEntity({
    this.id,
    this.title,
    this.content,
    this.isAnonymous,
    this.category,
    this.createdAt,
    this.userId,
    this.user,
    this.likeCount,
  });

  final int? id;
  final int? likeCount;
  final String? title;
  final String? content;
  final bool? isAnonymous;
  final String? category;
  final DateTime? createdAt;
  final String? userId;
  final UserEntity? user;

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        isAnonymous,
        category,
        createdAt,
        userId,
        user,
        likeCount,
      ];
}
