import 'package:kalm/model/auth/user_model.dart';

class DetailCurhatModel {
  DetailCurhatModel({
    required this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  bool success;
  int? statusCode;
  String? message;
  Data? data;

  factory DetailCurhatModel.fromJson(Map<String, dynamic> json) =>
      DetailCurhatModel(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["mesage"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "mesage": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.curhatan,
  });

  DetailCurhatan? curhatan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        curhatan: DetailCurhatan.fromJson(json["curhatan"]),
      );

  Map<String, dynamic> toJson() => {
        "curhatan": curhatan!.toJson(),
      };
}

class DetailCurhatan {
  DetailCurhatan({
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

  int? id;
  String? title;
  String? content;
  bool? isAnonymous;
  String? category;
  DateTime? createdAt;
  String? userId;
  User? user;
  List<DetailComment>? comments;
  List<CurhatLike>? curhatLike;

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
}

class DetailComment {
  DetailComment(
      {this.id,
      this.content,
      this.createdAt,
      this.curhatanId,
      this.userId,
      this.username,
      this.isAnonymous});

  int? id;
  String? content;
  DateTime? createdAt;
  String? curhatanId;
  String? userId;
  String? username;
  bool? isAnonymous;

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
}

class CurhatLike {
  CurhatLike({
    this.userId,
    this.id,
    this.curhatanId,
    this.createdAt,
    this.updatedAt,
  });

  String? userId;
  int? id;
  String? curhatanId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CurhatLike.fromJson(Map<String, dynamic> json) => CurhatLike(
        userId: json["user_id"],
        id: json["id"],
        curhatanId: json["curhatan_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "id": id,
        "curhatan_id": curhatanId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
