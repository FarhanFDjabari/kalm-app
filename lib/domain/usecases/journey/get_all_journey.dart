import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/journey/journey_entity.dart';
import 'package:kalm/domain/repository/journey_repository.dart';

class GetAllJourney {
  final JourneyRepository repository;

  GetAllJourney({required this.repository});

  Future<Either<String, List<JourneyEntity>>> execute({required int userId}) {
    return repository.getAllJourney(userId: userId);
  }
}
