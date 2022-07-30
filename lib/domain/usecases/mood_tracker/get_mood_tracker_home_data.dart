import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_home_entity.dart';
import 'package:kalm/domain/repository/mood_tracker_repository.dart';

class GetMoodTrackerHomeData {
  final MoodTrackerRepository repository;

  GetMoodTrackerHomeData({required this.repository});

  Future<Either<String, MoodTrackerHomeEntity>> execute({required int userId}) {
    return repository.getMoodTrackerHomeData(userId: userId);
  }
}
