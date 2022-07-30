import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class JournalTaskModel extends Equatable implements ModelFactory {
  const JournalTaskModel({
    required this.item,
  });

  final JournalItem item;

  factory JournalTaskModel.fromJson(Map<String, dynamic> json) =>
      JournalTaskModel(
        item: JournalItem.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "item": item.toJson(),
      };

  @override
  List<Object?> get props => [item];
}

class JournalItem extends Equatable implements ModelFactory {
  const JournalItem({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.journeyComponentId,
    required this.journeyId,
    required this.questions,
  });

  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int journeyComponentId;
  final int journeyId;
  final List<Question> questions;

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

  @override
  List<Object?> get props => [
        id,
        name,
        createdAt,
        journeyComponentId,
        journeyId,
        questions,
      ];
}

class Question extends Equatable implements ModelFactory {
  const Question({
    required this.id,
    required this.question,
    required this.journalId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String question;
  final int journalId;
  final DateTime createdAt;
  final DateTime updatedAt;

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

  @override
  List<Object?> get props => [
        id,
        question,
        journalId,
        createdAt,
        updatedAt,
      ];
}
