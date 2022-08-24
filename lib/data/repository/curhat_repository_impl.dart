import 'package:dartz/dartz.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/curhat/curhat_service.dart';
import 'package:kalm/domain/entity/curhat/detail_curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/create_curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/comment_entity.dart';
import 'package:kalm/domain/repository/curhat_repository.dart';

class CurhatRepositoryImpl extends CurhatRepository {
  @override
  Future<Either<String, CommentEntity>> createComment(
      {required int userId,
      required int curhatId,
      required String content,
      required bool isAnonymous}) async {
    final client = await curhatClient();
    final response = client.createNewComment(
      body: {
        'user_id': userId,
        'curhat_id': curhatId,
        'content': content,
        'is_anonymous': isAnonymous,
      },
    );
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });

    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.comment!.toEntity());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, CreateCurhatanEntity>> createCurhat(
      {required int userId,
      required bool isAnonymous,
      required String content,
      required String topic}) async {
    final client = await curhatClient();
    final response = client.createNewCurhat(
      body: {
        'user_id': userId,
        'is_anonymous': isAnonymous,
        'content': content,
        'topic': topic,
      },
    );
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });

    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.curhatan!.toEntity());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, List<CurhatanEntity>>> getAllCurhat(
      {required int userId}) async {
    final client = await curhatClient();
    final response = client.fetchAllCurhat(userId: userId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.curhatans!.map((e) => e.toEntity()).toList());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, List<CurhatanEntity>>> getAllCurhatByCategory(
      {required int userId, required String category}) async {
    final client = await curhatClient();
    final response =
        client.fetchCurhatByCategory(category: category, userId: userId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.curhatans!.map((e) => e.toEntity()).toList());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, DetailCurhatanEntity>> getCurhatDetail(
      {required int userId, required int curhatId}) async {
    final client = await curhatClient();
    final response = client.fetchCurhatById(userId: userId, curhatId: curhatId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.curhatan!.toEntity());
    } else {
      return Left(result.message);
    }
  }
}
