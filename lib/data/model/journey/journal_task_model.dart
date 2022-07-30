import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/journey/question_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/journey/journal_item_entity.dart';
import 'package:kalm/domain/entity/journey/question_entity.dart';

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

  JournalItemEntity toEntity() {
    return JournalItemEntity(
      id: id,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
      journeyComponentId: journeyComponentId,
      journeyId: journeyId,
      questions: questions.map((e) => e.toEntity()).toList(),
    );
  }

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
