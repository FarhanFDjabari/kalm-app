import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/journey/quote_entity.dart';
import 'package:kalm/domain/repository/journey_repository.dart';

class GetQuote {
  final JourneyRepository repository;

  GetQuote({required this.repository});

  Future<Either<String, QuoteEntity>> execute({
    required int userId,
    required int journeyId,
  }) {
    return repository.getQuote(userId: userId, journeyId: journeyId);
  }
}
