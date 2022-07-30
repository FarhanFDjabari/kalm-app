import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  const CommentEntity({
    this.userId,
    this.curhatanId,
    this.content,
    this.createdAt,
    this.id,
    this.username,
    this.isAnonymous,
  });

  final int? userId;
  final int? curhatanId;
  final String? content;
  final DateTime? createdAt;
  final bool? isAnonymous;
  final int? id;
  final String? username;

  @override
  List<Object?> get props => [
        userId,
        curhatanId,
        content,
        createdAt,
        id,
        username,
        isAnonymous,
      ];
}
