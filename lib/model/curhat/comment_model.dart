class CommentModel {
  CommentModel({
    required this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  bool success;
  int? statusCode;
  String? message;
  Data? data;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
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
    this.comment,
  });

  Comment? comment;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        comment: Comment.fromJson(json["comment"]),
      );

  Map<String, dynamic> toJson() => {
        "comment": comment!.toJson(),
      };
}

class Comment {
  Comment({
    this.userId,
    this.curhatanId,
    this.content,
    this.createdAt,
    this.id,
    this.username,
    this.isAnonymous,
  });

  int? userId;
  int? curhatanId;
  String? content;
  DateTime? createdAt;
  bool? isAnonymous;
  int? id;
  String? username;

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
}
