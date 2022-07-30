import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/auth/user_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/curhat/curhat_entity.dart';

class CurhatModel extends Equatable implements ModelFactory {
  const CurhatModel({
    this.curhatans,
  });

  final List<Curhatan>? curhatans;

  factory CurhatModel.fromJson(Map<String, dynamic> json) => CurhatModel(
        curhatans: List<Curhatan>.from(
            json["curhatans"].map((x) => Curhatan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "curhatans": List<dynamic>.from(curhatans!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [curhatans];
}

class Curhatan extends Equatable implements ModelFactory {
  const Curhatan({
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
  final User? user;

  factory Curhatan.fromJson(Map<String, dynamic> json) => Curhatan(
        id: json["id"],
        title: json["tittle"],
        content: json["content2"],
        isAnonymous: json["is_anonymous"],
        category: json["category"],
        createdAt: DateTime.parse(json["created_at"]),
        userId: json["user_id"],
        user: User.fromJson(json["user"]),
        likeCount: json["like_count"],
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
        "like_count": likeCount,
      };

  CurhatanEntity toEntity() {
    return CurhatanEntity(
      id: id,
      userId: userId,
      title: title,
      user: user?.toEntity(),
      category: category,
      content: content,
      createdAt: createdAt,
    );
  }

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
