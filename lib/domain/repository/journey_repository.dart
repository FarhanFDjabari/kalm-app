import 'package:kalm/domain/entity/journey/journal_item_entity.dart';
import 'package:kalm/domain/entity/journey/journey_detail_entity.dart';
import 'package:kalm/domain/entity/journey/journey_entity.dart';
import 'package:kalm/domain/entity/journey/meditation_item_entity.dart';
import 'package:kalm/domain/entity/journey/quote_entity.dart';

abstract class JourneyRepository {
  Future<List<JourneyEntity>> getAllJourney({required int userId});
  Future<List<DetailJourneyEntity>> getJourneyDetail({
    required int userId,
    required int journeyId,
  });
  Future<JournalItemEntity> getJournalTask({
    required int userId,
    required int taskId,
  });
  Future<String> postJournalTask({
    required int userId,
    required int componentId,
    required int journeyid,
    required List<Map<String, dynamic>> answers,
  });
  Future<QuoteEntity> getQuote({
    required int userId,
    required int journeyId,
  });
  Future<MeditationItemEntity> getMeditationTask({
    required int userId,
    required int taskId,
  });
  Future<String> postMeditationTask({
    required int userId,
    required int componentId,
    required int journeyid,
  });
}
