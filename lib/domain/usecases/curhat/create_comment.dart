import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/curhat/comment_entity.dart';
import 'package:kalm/domain/repository/curhat_repository.dart';

class CreateComment {
  final CurhatRepository repository;

  CreateComment({required this.repository});

  Future<Either<String, CommentEntity>> execute({
    required int userId,
    required int curhatId,
    required String content,
    required bool isAnonymous,
  }) {
    return repository.createComment(
      userId: userId,
      curhatId: curhatId,
      content: content,
      isAnonymous: isAnonymous,
    );
  }
}
