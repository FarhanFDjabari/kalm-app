import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/curhat/comment_entity.dart';
import 'package:kalm/domain/entity/curhat/create_curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/detail_curhat_entity.dart';

abstract class CurhatRepository {
  Future<Either<String, List<CurhatanEntity>>> getAllCurhat(
      {required int userId});
  Future<Either<String, List<CurhatanEntity>>> getAllCurhatByCategory({
    required int userId,
    required String category,
  });
  Future<Either<String, DetailCurhatanEntity>> getCurhatDetail({
    required int userId,
    required int curhatId,
  });
  Future<Either<String, CreateCurhatanEntity>> createCurhat({
    required int userId,
    required bool isAnonymous,
    required String content,
    required String topic,
  });
  Future<Either<String, CommentEntity>> createComment({
    required int userId,
    required int curhatId,
    required String content,
    required bool isAnonymous,
  });
}
