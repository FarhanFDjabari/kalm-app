import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/curhat/curhat_entity.dart';
import 'package:kalm/domain/repository/curhat_repository.dart';

class GetAllCurhatByCategory {
  final CurhatRepository repository;

  GetAllCurhatByCategory({required this.repository});

  Future<Either<String, List<CurhatanEntity>>> execute(
      {required int userId, required String category}) {
    return repository.getAllCurhatByCategory(
        userId: userId, category: category);
  }
}
