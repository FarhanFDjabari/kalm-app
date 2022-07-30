import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class DetailComment extends Equatable implements ModelFactory {
  const DetailComment(
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

  factory DetailComment.fromJson(Map<String, dynamic> json) => DetailComment(
        id: json["id"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        curhatanId: json["curhatan_id"],
        userId: json["user_id"],
        username: json["username"],
        isAnonymous: json["is_anonymous"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content2": content,
        "created_at": createdAt!.toIso8601String(),
        "curhatan_id": curhatanId,
        "user_id": userId,
        "username": username,
        "is_anonymous": isAnonymous
      };

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
