import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/curhat/curhat_like_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/curhat/create_curhat_entity.dart';

class CreateCurhatanModel extends Equatable implements ModelFactory {
  const CreateCurhatanModel({
    this.curhatan,
  });

  final CreateCurhatan? curhatan;

  factory CreateCurhatanModel.fromJson(Map<String, dynamic> json) =>
      CreateCurhatanModel(
        curhatan: CreateCurhatan.fromJson(json["curhatan"]),
      );

  Map<String, dynamic> toJson() => {
        "curhatan": curhatan,
      };

  @override
  List<Object?> get props => [curhatan];
}

class CreateCurhatan extends Equatable implements ModelFactory {
  const CreateCurhatan({
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
  final List<CurhatLike>? curhatLike;

  factory CreateCurhatan.fromJson(Map<String, dynamic> json) => CreateCurhatan(
        userId: json["user_id"],
        isAnonymous: json["is_anonymous"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        content2: json["content2"],
        likeCount: json["like_count"],
        curhatLike: json['curhat_like'] != null
            ? List<CurhatLike>.from(json["curhat_like"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "is_anonymous": isAnonymous,
        "content": content,
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "content2": content2,
        "like_count": likeCount,
        "curhat_like": List<dynamic>.from(curhatLike!.map((x) => x)),
      };

  CreateCurhatanEntity toEntity() {
    return CreateCurhatanEntity(
      id: id,
      userId: userId,
      isAnonymous: isAnonymous,
      createdAt: createdAt,
      content: content,
      content2: content2,
      curhatLike: curhatLike?.map((e) => e.toEntity()).toList(),
      likeCount: likeCount,
    );
  }

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
