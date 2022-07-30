import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/auth/user_model.dart';
import 'package:kalm/data/model/curhat/curhat_like_model.dart';
import 'package:kalm/data/model/curhat/detail_comment_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/curhat/detail_curhat_entity.dart';

class DetailCurhatModel extends Equatable implements ModelFactory {
  const DetailCurhatModel({
    this.curhatan,
  });

  final DetailCurhatan? curhatan;

  factory DetailCurhatModel.fromJson(Map<String, dynamic> json) =>
      DetailCurhatModel(
        curhatan: DetailCurhatan.fromJson(json["curhatan"]),
      );

  Map<String, dynamic> toJson() => {
        "curhatan": curhatan!.toJson(),
      };

  @override
  List<Object?> get props => [curhatan];
}

class DetailCurhatan extends Equatable implements ModelFactory {
  const DetailCurhatan({
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
  final User? user;
  final List<DetailComment>? comments;
  final List<CurhatLike>? curhatLike;

  factory DetailCurhatan.fromJson(Map<String, dynamic> json) => DetailCurhatan(
        id: json["id"],
        title: json["tittle"],
        content: json["content2"],
        isAnonymous: json["is_anonymous"],
        category: json["category"],
        curhatLike: List<CurhatLike>.from(
            json["curhat_like"].map((x) => CurhatLike.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        userId: json["user_id"],
        user: User.fromJson(json["user"]),
        comments: List<DetailComment>.from(
            json["comments"].map((x) => DetailComment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tittle": title,
        "content2": content,
        "is_anonymous": isAnonymous,
        "category": category,
        "created_at": createdAt!.toIso8601String(),
        "user_id": userId,
        "user": user!.toJson(),
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
      };

  DetailCurhatanEntity toEntity() {
    return DetailCurhatanEntity(
      id: id,
      userId: userId,
      user: user?.toEntity(),
      title: title,
      isAnonymous: isAnonymous,
      category: category,
      comments: comments?.map((e) => e.toEntity()).toList(),
      content: content,
      createdAt: createdAt,
      curhatLike: curhatLike?.map((e) => e.toEntity()).toList(),
    );
  }

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
