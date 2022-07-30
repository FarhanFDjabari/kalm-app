import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_post_entity.dart';
import 'package:kalm/domain/repository/mood_tracker_repository.dart';

class PostMood {
  final MoodTrackerRepository repository;

  PostMood({required this.repository});

  Future<Either<String, MoodTrackerPostEntity>> execute({
    required int userId,
    required int mood,
    required List<String> reasons,
  }) {
    return repository.postMood(userId: userId, mood: mood, reasons: reasons);
  }
}
