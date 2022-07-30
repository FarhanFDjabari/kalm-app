import 'package:kalm/domain/entity/curhat/comment_entity.dart';
import 'package:kalm/domain/entity/curhat/create_curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/detail_curhat_entity.dart';

abstract class CurhatRepository {
  Future<List<CurhatanEntity>> getAllCurhat({required int userId});
  Future<List<CurhatanEntity>> getAllCurhatByCategory({
    required int userId,
    required String category,
  });
  Future<DetailCurhatanEntity> getCurhatDetail({
    required int userId,
    required int curhatId,
  });
  Future<CreateCurhatanEntity> createCurhat({
    required int userId,
    required bool isAnonymous,
    required String content,
    required String topic,
  });
  Future<CommentEntity> createComment({
    required int userId,
    required int curhatId,
    required String content,
    required bool isAnonymous,
  });
}
