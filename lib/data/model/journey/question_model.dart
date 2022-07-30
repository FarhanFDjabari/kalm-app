import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/journey/question_entity.dart';

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

  QuestionEntity toEntity() {
    return QuestionEntity(
      id: id,
      question: question,
      journalId: journalId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        question,
        journalId,
        createdAt,
        updatedAt,
      ];
}
