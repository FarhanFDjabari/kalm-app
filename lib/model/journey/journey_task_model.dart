import 'package:kalm/model/meditation/playlist_model.dart';

class JourneyTaskModel {
  JourneyTaskModel({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  bool success;
  int statusCode;
  String message;
  Data? data;

  factory JourneyTaskModel.fromJson(Map<String, dynamic> json) =>
      JourneyTaskModel(
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
    required this.item,
  });

  Item item;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        item: Item.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "item": item.toJson(),
      };
}

class Item {
  Item({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.coverImage,
    this.questions,
  });

  int id;
  String name;
  DateTime createdAt;
  RoundedImage coverImage;
  List<Question>? questions;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        coverImage: RoundedImage.fromJson(json["cover_image"]),
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "cover_image": coverImage.toJson(),
        "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    required this.id,
    required this.question,
    required this.journalId,
    required this.createdAt,
  });

  int id;
  String question;
  String journalId;
  DateTime createdAt;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        journalId: json["journal_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "journal_id": journalId,
        "created_at": createdAt.toIso8601String(),
      };
}
