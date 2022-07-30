import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/curhat/create_curhat_entity.dart';
import 'package:kalm/domain/repository/curhat_repository.dart';

class CreateCurhat {
  final CurhatRepository repository;

  CreateCurhat({required this.repository});

  Future<Either<String, CreateCurhatanEntity>> execute({
    required int userId,
    required bool isAnonymous,
    required String content,
    required String topic,
  }) {
    return repository.createCurhat(
      userId: userId,
      isAnonymous: isAnonymous,
      content: content,
      topic: topic,
    );
  }
}
