import 'package:dartz/dartz.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/journey/journey_service.dart';
import 'package:kalm/data/sources/remote/services/journey/journey_service_supa.dart';
import 'package:kalm/domain/entity/journey/quote_entity.dart';
import 'package:kalm/domain/entity/journey/meditation_item_entity.dart';
import 'package:kalm/domain/entity/journey/journey_entity.dart';
import 'package:kalm/domain/entity/journey/journey_detail_entity.dart';
import 'package:kalm/domain/entity/journey/journal_item_entity.dart';
import 'package:kalm/domain/repository/journey_repository.dart';

class JourneyRepositoryImpl extends JourneyRepository {
  @override
  Future<Either<String, List<JourneyEntity>>> getAllJourney(
      {required int userId}) async {
    try {
      final client = journeyServiceSupa;
      final result = await client.fetchAllJourney(userId: userId);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, JournalItemEntity>> getJournalTask(
      {required int userId, required int taskId}) async {
    try {
      final client = journeyServiceSupa;
      final result =
          await client.getJournalTask(userId: userId, taskId: taskId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, DetailJourneyEntity>> getJourneyDetail(
      {required int userId, required int journeyId}) async {
    try {
      final client = journeyServiceSupa;
      final result =
          await client.getJourneyById(journeyId: journeyId, userId: userId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, MeditationItemEntity>> getMeditationTask(
      {required int userId, required int taskId}) async {
    try {
      final client = journeyServiceSupa;
      final result =
          await client.getMeditationTask(userId: userId, taskId: taskId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, QuoteEntity>> getQuote(
      {required int userId, required int journeyId}) async {
    try {
      final client = journeyServiceSupa;
      final result =
          await client.getJourneyQuote(userId: userId, journeyId: journeyId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> postJournalTask(
      {required int userId,
      required int componentId,
      required int journeyId,
      required List<Map<String, dynamic>> answers}) async {
    try {
      final client = journeyServiceSupa;
      final result = await client.postJournalTask(
          userId: userId,
          componentId: componentId,
          journeyId: journeyId,
          answers: answers);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> postMeditationTask(
      {required int userId,
      required int componentId,
      required int journeyId}) async {
    try {
      final client = journeyServiceSupa;
      final result = await client.postMeditationTask(
          userId: userId, componentId: componentId, journeyId: journeyId);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
