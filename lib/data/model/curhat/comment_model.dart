import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/curhat/comment_entity.dart';

class CommentModel extends Equatable implements ModelFactory {
  const CommentModel({
    this.comment,
  });

  final Comment? comment;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        comment: Comment.fromJson(json["comment"]),
      );

  Map<String, dynamic> toJson() => {
        "comment": comment!.toJson(),
      };

  @override
  List<Object?> get props => [comment];
}

class Comment extends Equatable implements ModelFactory {
  const Comment({
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

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      userId: json["user_id"],
      curhatanId: json["curhatan_id"],
      content: json["content"],
      createdAt: DateTime.parse(json["created_at"]),
      id: json["id"],
      username: json["username"],
      isAnonymous: json["is_anonymous"]);

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "curhatan_id": curhatanId,
        "content": content,
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "username": username,
        "is_anonymous": isAnonymous
      };

  CommentEntity toEntity() {
    return CommentEntity(
      id: id,
      userId: userId,
      username: username,
      curhatanId: curhatanId,
      createdAt: createdAt,
      content: content,
      isAnonymous: isAnonymous,
    );
  }

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
