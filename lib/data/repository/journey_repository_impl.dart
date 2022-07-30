import 'package:dartz/dartz.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
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
  Future<Either<String, List<JourneyEntity>>> getAllJourney(
      {required int userId}) async {
    await service
        .fetchAllJourney(userId: userId)
        .validateStatus()
        .then((response) {
      return Right(response.data!.journeys!.map((e) => e.toEntity()).toList());
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, JournalItemEntity>> getJournalTask(
      {required int userId, required int taskId}) async {
    await service
        .getJournalTask(userId: userId, taskId: taskId)
        .validateStatus()
        .then((response) {
      return Right(response.data!.item.toEntity());
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, DetailJourneyEntity>> getJourneyDetail(
      {required int userId, required int journeyId}) async {
    await service
        .getJourneyById(journeyId: journeyId, userId: userId)
        .validateStatus()
        .then((response) {
      return Right(response.data!.journey.toEntity());
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, MeditationItemEntity>> getMeditationTask(
      {required int userId, required int taskId}) async {
    await service
        .getMeditationTask(userId: userId, taskId: taskId)
        .validateStatus()
        .then((response) {
      return Right(response.data!.item.toEntity());
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, QuoteEntity>> getQuote(
      {required int userId, required int journeyId}) async {
    await service
        .getJourneyQuote(userId: userId, journeyId: journeyId)
        .validateStatus()
        .then((response) {
      return Right(response.data!.quote.toEntity());
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, String>> postJournalTask(
      {required int userId,
      required int componentId,
      required int journeyId,
      required List<Map<String, dynamic>> answers}) async {
    await service
        .postJournalTask(
          userId: userId,
          componentId: componentId,
          journeyId: journeyId,
          answers: answers,
        )
        .validateStatus()
        .then((response) {
      return Right(response.message);
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, String>> postMeditationTask(
      {required int userId,
      required int componentId,
      required int journeyId}) async {
    await service
        .postMeditationTask(
          userId: userId,
          componentId: componentId,
          journeyId: journeyId,
        )
        .validateStatus()
        .then((response) {
      return Right(response.message);
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }
}
