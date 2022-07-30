import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/journey/journey_detail_entity.dart';
import 'package:kalm/domain/repository/journey_repository.dart';

class GetJourneyDetail {
  final JourneyRepository repository;

  GetJourneyDetail({required this.repository});

  Future<Either<String, DetailJourneyEntity>> execute({
    required int userId,
    required int journeyId,
  }) {
    return repository.getJourneyDetail(userId: userId, journeyId: journeyId);
  }
}
