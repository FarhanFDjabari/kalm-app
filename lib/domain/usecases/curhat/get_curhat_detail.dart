import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/curhat/detail_curhat_entity.dart';
import 'package:kalm/domain/repository/curhat_repository.dart';

class GetCurhatDetail {
  final CurhatRepository repository;

  GetCurhatDetail({required this.repository});

  Future<Either<String, DetailCurhatanEntity>> execute(
      {required int userId, required int curhatId}) {
    return repository.getCurhatDetail(userId: userId, curhatId: curhatId);
  }
}
