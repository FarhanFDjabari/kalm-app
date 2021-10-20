import 'package:kalm/model/auth/user_model.dart';

class CurhatModel {
  CurhatModel({
    required this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  bool success;
  int? statusCode;
  String? message;
  Data? data;

  factory CurhatModel.fromJson(Map<String, dynamic> json) => CurhatModel(
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
    this.curhatans,
  });

  List<Curhatan>? curhatans;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        curhatans: List<Curhatan>.from(
            json["curhatans"].map((x) => Curhatan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "curhatans": List<dynamic>.from(curhatans!.map((x) => x.toJson())),
      };
}

class Curhatan {
  Curhatan({
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

  int? id;
  int? likeCount;
  String? title;
  String? content;
  bool? isAnonymous;
  String? category;
  DateTime? createdAt;
  String? userId;
  User? user;

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
}
