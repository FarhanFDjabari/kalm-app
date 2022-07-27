class CreateCurhatResponse {
  CreateCurhatResponse({
    required this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  bool success;
  int? statusCode;
  String? message;
  Data? data;

  factory CreateCurhatResponse.fromJson(Map<String, dynamic> json) =>
      CreateCurhatResponse(
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

  CreateCurhatan? curhatan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        curhatan: CreateCurhatan.fromJson(json["curhatan"]),
      );

  Map<String, dynamic> toJson() => {
        "curhatan": curhatan,
      };
}

class CreateCurhatan {
  CreateCurhatan({
    this.userId,
    this.isAnonymous,
    this.content,
    this.createdAt,
    this.id,
    this.content2,
    this.likeCount,
    this.curhatLike,
  });

  int? userId;
  bool? isAnonymous;
  String? content;
  DateTime? createdAt;
  int? id;
  String? content2;
  int? likeCount;
  List<dynamic>? curhatLike;

  factory CreateCurhatan.fromJson(Map<String, dynamic> json) => CreateCurhatan(
        userId: json["user_id"],
        isAnonymous: json["is_anonymous"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        content2: json["content2"],
        likeCount: json["like_count"],
        curhatLike: json['curhat_like'] != null
            ? List<dynamic>.from(json["curhat_like"].map((x) => x))
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
}
