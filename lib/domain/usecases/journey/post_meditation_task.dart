import 'package:dartz/dartz.dart';
import 'package:kalm/domain/repository/journey_repository.dart';

class PostMeditationTask {
  final JourneyRepository repository;

  PostMeditationTask({required this.repository});

  Future<Either<String, String>> execute({
    required int userId,
    required int componentId,
    required int journeyId,
  }) {
    return repository.postMeditationTask(
      userId: userId,
      componentId: componentId,
      journeyId: journeyId,
    );
  }
}
