import 'package:equatable/equatable.dart';
import 'package:kalm/domain/entity/journey/question_entity.dart';

class JournalItemEntity extends Equatable {
  const JournalItemEntity({
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
  final List<QuestionEntity> questions;

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
