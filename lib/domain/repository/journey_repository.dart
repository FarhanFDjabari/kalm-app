import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/journey/journal_item_entity.dart';
import 'package:kalm/domain/entity/journey/journey_detail_entity.dart';
import 'package:kalm/domain/entity/journey/journey_entity.dart';
import 'package:kalm/domain/entity/journey/meditation_item_entity.dart';
import 'package:kalm/domain/entity/journey/quote_entity.dart';

abstract class JourneyRepository {
  Future<Either<String, List<JourneyEntity>>> getAllJourney(
      {required int userId});
  Future<Either<String, DetailJourneyEntity>> getJourneyDetail({
    required int userId,
    required int journeyId,
  });
  Future<Either<String, JournalItemEntity>> getJournalTask({
    required int userId,
    required int taskId,
  });
  Future<Either<String, String>> postJournalTask({
    required int userId,
    required int componentId,
    required int journeyId,
    required List<Map<String, dynamic>> answers,
  });
  Future<Either<String, QuoteEntity>> getQuote({
    required int userId,
    required int journeyId,
  });
  Future<Either<String, MeditationItemEntity>> getMeditationTask({
    required int userId,
    required int taskId,
  });
  Future<Either<String, String>> postMeditationTask({
    required int userId,
    required int componentId,
    required int journeyId,
  });
}
