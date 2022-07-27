class JournalTaskModel {
  JournalTaskModel({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  bool success;
  int statusCode;
  String message;
  Data? data;

  factory JournalTaskModel.fromJson(Map<String, dynamic> json) =>
      JournalTaskModel(
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

  JournalItem item;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        item: JournalItem.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "item": item.toJson(),
      };
}

class JournalItem {
  JournalItem({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.journeyComponentId,
    required this.journeyId,
    required this.questions,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  int journeyComponentId;
  int journeyId;
  List<Question> questions;

  factory JournalItem.fromJson(Map<String, dynamic> json) => JournalItem(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        journeyComponentId: json["journey_component_id"],
        journeyId: json["journey_id"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "journey_component_id": journeyComponentId,
        "journey_id": journeyId,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    required this.id,
    required this.question,
    required this.journalId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String question;
  int journalId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        journalId: json["journal_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "journal_id": journalId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
