import 'package:equatable/equatable.dart';

class DetailCommentEntity extends Equatable {
  const DetailCommentEntity(
      {this.id,
      this.content,
      this.createdAt,
      this.curhatanId,
      this.userId,
      this.username,
      this.isAnonymous});

  final int? id;
  final String? content;
  final DateTime? createdAt;
  final String? curhatanId;
  final String? userId;
  final String? username;
  final bool? isAnonymous;

  @override
  List<Object?> get props => [
        id,
        content,
        createdAt,
        curhatanId,
        userId,
        username,
        isAnonymous,
      ];
}
