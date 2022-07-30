import 'package:equatable/equatable.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/entity/curhat/curhat_like_entity.dart';
import 'package:kalm/domain/entity/curhat/detail_comment_entity.dart';

class DetailCurhatanEntity extends Equatable {
  const DetailCurhatanEntity({
    this.id,
    this.title,
    this.content,
    this.isAnonymous,
    this.category,
    this.createdAt,
    this.curhatLike,
    this.userId,
    this.user,
    this.comments,
  });

  final int? id;
  final String? title;
  final String? content;
  final bool? isAnonymous;
  final String? category;
  final DateTime? createdAt;
  final String? userId;
  final UserEntity? user;
  final List<DetailCommentEntity>? comments;
  final List<CurhatLikeEntity>? curhatLike;

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        isAnonymous,
        category,
        curhatLike,
        createdAt,
        userId,
        user,
        comments,
      ];
}
