import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/journey/journal_item_entity.dart';
import 'package:kalm/domain/repository/journey_repository.dart';

class GetJournalTask {
  final JourneyRepository repository;

  GetJournalTask({required this.repository});

  Future<Either<String, JournalItemEntity>> execute(
      {required int userId, required int taskId}) {
    return repository.getJournalTask(userId: userId, taskId: taskId);
  }
}
