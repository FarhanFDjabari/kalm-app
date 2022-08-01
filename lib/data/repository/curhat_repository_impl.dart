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
    await curhatClient().then((client) {
      client
          .createNewComment(
            userId: userId,
            curhatId: curhatId,
            content: content,
            isAnonymous: isAnonymous,
          )
          .validateStatus()
          .then((response) {
        return Right(response.data!.comment!.toEntity());
      });
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, CreateCurhatanEntity>> createCurhat(
      {required int userId,
      required bool isAnonymous,
      required String content,
      required String topic}) async {
    await curhatClient().then((client) {
      client
          .createNewCurhat(
            userId: userId,
            isAnonymous: isAnonymous,
            content: content,
            topic: topic,
          )
          .validateStatus()
          .then((response) {
        return Right(response.data!.curhatan!.toEntity());
      });
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, List<CurhatanEntity>>> getAllCurhat(
      {required int userId}) async {
    await curhatClient().then((client) {
      client.fetchAllCurhat(userId: userId).validateStatus().then((response) {
        return Right(
            response.data!.curhatans!.map((e) => e.toEntity()).toList());
      });
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, List<CurhatanEntity>>> getAllCurhatByCategory(
      {required int userId, required String category}) async {
    await curhatClient().then((client) {
      client
          .fetchCurhatByCategory(category: category, userId: userId)
          .validateStatus()
          .then((response) {
        return Right(
            response.data!.curhatans!.map((e) => e.toEntity()).toList());
      });
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, DetailCurhatanEntity>> getCurhatDetail(
      {required int userId, required int curhatId}) async {
    await curhatClient().then((client) {
      client
          .fetchCurhatById(userId: userId, curhatId: curhatId)
          .validateStatus()
          .then((response) {
        return Right(response.data!.curhatan!.toEntity());
      });
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }
}
