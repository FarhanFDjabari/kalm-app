import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/journey/meditation_item_entity.dart';
import 'package:kalm/domain/repository/journey_repository.dart';

class GetMeditationTask {
  final JourneyRepository repository;

  GetMeditationTask({required this.repository});

  Future<Either<String, MeditationItemEntity>> execute(
      {required int userId, required int taskId}) {
    return repository.getMeditationTask(userId: userId, taskId: taskId);
  }
}
