import 'package:dartz/dartz.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/curhat/curhat_service_supa.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/entity/curhat/curhat_like_entity.dart';
import 'package:kalm/domain/entity/curhat/detail_comment_entity.dart';
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
    try {
      final client = curhatServiceSupa;

      final result = await client
          .createNewComment(
              userId: userId,
              curhatId: curhatId,
              content: content,
              isAnonymous: isAnonymous)
          .handleError((onError) {
        return Left(onError.toString());
      });

      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CreateCurhatanEntity>> createCurhat(
      {required int userId,
      required bool isAnonymous,
      required String content,
      required String topic}) async {
    try {
      final client = curhatServiceSupa;
      final result = await client
          .createNewCurhat(
              userId: userId,
              isAnonymous: isAnonymous,
              content: content,
              topic: topic)
          .handleError((onError) {
        return Left(onError.toString());
      });

      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CurhatanEntity>>> getAllCurhat(
      {required int userId}) async {
    try {
      final client = curhatServiceSupa;
      final result =
          await client.fetchAllCurhat(userId: userId).handleError((onError) {
        return Left(onError.toString());
      });

      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CurhatanEntity>>> getAllCurhatByCategory(
      {required int userId, required String category}) async {
    try {
      final client = curhatServiceSupa;
      final result = await client
          .fetchCurhatByCategory(category: category, userId: userId)
          .handleError((onError) {
        return Left(onError.toString());
      });
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, DetailCurhatanEntity>> getCurhatDetail(
      {required int userId, required int curhatId}) async {
    try {
      final client = curhatServiceSupa;
      final result = await client
          .fetchCurhatById(userId: userId, curhatId: curhatId)
          .handleError((onError) {
        return Left(onError.toString());
      });

      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
