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
  @override
  Future<Either<String, List<JourneyEntity>>> getAllJourney(
      {required int userId}) async {
    final client = await journeyClient();
    final response = client.fetchAllJourney(userId: userId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });

    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.journeys!.map((e) => e.toEntity()).toList());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, JournalItemEntity>> getJournalTask(
      {required int userId, required int taskId}) async {
    final client = await journeyClient();
    final response = client.getJournalTask(userId: userId, taskId: taskId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.item.toEntity());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, DetailJourneyEntity>> getJourneyDetail(
      {required int userId, required int journeyId}) async {
    final client = await journeyClient();
    final response =
        client.getJourneyById(journeyId: journeyId, userId: userId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.journey.toEntity());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, MeditationItemEntity>> getMeditationTask(
      {required int userId, required int taskId}) async {
    final client = await journeyClient();
    final response = client.getMeditationTask(userId: userId, taskId: taskId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });

    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.item.toEntity());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, QuoteEntity>> getQuote(
      {required int userId, required int journeyId}) async {
    final client = await journeyClient();
    final response =
        client.getJourneyQuote(userId: userId, journeyId: journeyId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });

    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.quote.toEntity());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, String>> postJournalTask(
      {required int userId,
      required int componentId,
      required int journeyId,
      required List<Map<String, dynamic>> answers}) async {
    final client = await journeyClient();
    final response = client.postJournalTask(
      userId: userId,
      componentId: componentId,
      journeyId: journeyId,
      answers: answers,
    );
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.message);
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, String>> postMeditationTask(
      {required int userId,
      required int componentId,
      required int journeyId}) async {
    final client = await journeyClient();
    final response = client.postMeditationTask(
      userId: userId,
      componentId: componentId,
      journeyId: journeyId,
    );
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });

    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.message);
    } else {
      return Left(result.message);
    }
  }
}
