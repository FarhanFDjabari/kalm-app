import 'package:dartz/dartz.dart';
import 'package:kalm/domain/repository/mood_tracker_repository.dart';

class GetMoodRecognition {
  final MoodTrackerRepository repository;

  GetMoodRecognition({required this.repository});

  Future<Either<String, Map<String, dynamic>>> execute(
      {required String imagePath}) {
    return repository.getMoodRecognition(imagePath: imagePath);
  }
}
