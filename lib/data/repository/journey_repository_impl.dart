import 'package:kalm/data/sources/remote/services/journey/journey_service.dart';
import 'package:kalm/domain/entity/journey/quote_entity.dart';
import 'package:kalm/domain/entity/journey/meditation_item_entity.dart';
import 'package:kalm/domain/entity/journey/journey_entity.dart';
import 'package:kalm/domain/entity/journey/journey_detail_entity.dart';
import 'package:kalm/domain/entity/journey/journal_item_entity.dart';
import 'package:kalm/domain/repository/journey_repository.dart';

class JourneyRepositoryImpl extends JourneyRepository {
  final JourneyService service;

  JourneyRepositoryImpl({required this.service});

  @override
  Future<List<JourneyEntity>> getAllJourney({required int userId}) {
    // TODO: implement getAllJourney
    throw UnimplementedError();
  }

  @override
  Future<JournalItemEntity> getJournalTask(
      {required int userId, required int taskId}) {
    // TODO: implement getJournalTask
    throw UnimplementedError();
  }

  @override
  Future<List<DetailJourneyEntity>> getJourneyDetail(
      {required int userId, required int journeyId}) {
    // TODO: implement getJourneyDetail
    throw UnimplementedError();
  }

  @override
  Future<MeditationItemEntity> getMeditationTask(
      {required int userId, required int taskId}) {
    // TODO: implement getMeditationTask
    throw UnimplementedError();
  }

  @override
  Future<QuoteEntity> getQuote({required int userId, required int journeyId}) {
    // TODO: implement getQuote
    throw UnimplementedError();
  }

  @override
  Future<String> postJournalTask(
      {required int userId,
      required int componentId,
      required int journeyid,
      required List<Map<String, dynamic>> answers}) {
    // TODO: implement postJournalTask
    throw UnimplementedError();
  }

  @override
  Future<String> postMeditationTask(
      {required int userId, required int componentId, required int journeyid}) {
    // TODO: implement postMeditationTask
    throw UnimplementedError();
  }
}
