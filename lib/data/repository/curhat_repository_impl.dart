import 'package:kalm/data/sources/remote/services/curhat/curhat_service.dart';
import 'package:kalm/domain/entity/curhat/detail_curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/create_curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/comment_entity.dart';
import 'package:kalm/domain/repository/curhat_repository.dart';

class CurhatRepositoryImpl extends CurhatRepository {
  final CurhatService service;

  CurhatRepositoryImpl({required this.service});

  @override
  Future<CommentEntity> createComment(
      {required int userId,
      required int curhatId,
      required String content,
      required bool isAnonymous}) {
    // TODO: implement createComment
    throw UnimplementedError();
  }

  @override
  Future<CreateCurhatanEntity> createCurhat(
      {required int userId,
      required bool isAnonymous,
      required String content,
      required String topic}) {
    // TODO: implement createCurhat
    throw UnimplementedError();
  }

  @override
  Future<List<CurhatanEntity>> getAllCurhat({required int userId}) {
    // TODO: implement getAllCurhat
    throw UnimplementedError();
  }

  @override
  Future<List<CurhatanEntity>> getAllCurhatByCategory(
      {required int userId, required String category}) {
    // TODO: implement getAllCurhatByCategory
    throw UnimplementedError();
  }

  @override
  Future<DetailCurhatanEntity> getCurhatDetail(
      {required int userId, required int curhatId}) {
    // TODO: implement getCurhatDetail
    throw UnimplementedError();
  }
}
