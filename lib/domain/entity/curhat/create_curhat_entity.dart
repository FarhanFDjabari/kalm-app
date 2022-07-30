import 'package:equatable/equatable.dart';
import 'package:kalm/domain/entity/curhat/curhat_like_entity.dart';

class CreateCurhatanEntity extends Equatable {
  const CreateCurhatanEntity({
    this.userId,
    this.isAnonymous,
    this.content,
    this.createdAt,
    this.id,
    this.content2,
    this.likeCount,
    this.curhatLike,
  });

  final int? userId;
  final bool? isAnonymous;
  final String? content;
  final DateTime? createdAt;
  final int? id;
  final String? content2;
  final int? likeCount;
  final List<CurhatLikeEntity>? curhatLike;

  @override
  List<Object?> get props => [
        userId,
        isAnonymous,
        content,
        createdAt,
        id,
        content2,
        likeCount,
        curhatLike,
      ];
}
