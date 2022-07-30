import 'package:dartz/dartz.dart';
import 'package:kalm/domain/repository/journey_repository.dart';

class PostJournalTask {
  final JourneyRepository repository;

  PostJournalTask({required this.repository});

  Future<Either<String, String>> execute({
    required int userId,
    required int componentId,
    required int journeyId,
    required List<Map<String, dynamic>> answers,
  }) {
    return repository.postJournalTask(
      userId: userId,
      componentId: componentId,
      journeyId: journeyId,
      answers: answers,
    );
  }
}
