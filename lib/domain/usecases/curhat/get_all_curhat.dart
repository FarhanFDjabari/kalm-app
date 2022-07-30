import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/curhat/curhat_entity.dart';
import 'package:kalm/domain/repository/curhat_repository.dart';

class GetAllCurhat {
  final CurhatRepository repository;

  GetAllCurhat({required this.repository});

  Future<Either<String, List<CurhatanEntity>>> execute({required int userId}) {
    return repository.getAllCurhat(userId: userId);
  }
}
