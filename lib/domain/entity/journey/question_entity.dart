import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  const QuestionEntity({
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

  @override
  List<Object?> get props => [
        id,
        question,
        journalId,
        createdAt,
        updatedAt,
      ];
}
