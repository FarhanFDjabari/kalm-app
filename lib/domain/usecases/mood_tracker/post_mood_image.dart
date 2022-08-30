import 'dart:io';

import 'package:kalm/domain/repository/mood_tracker_repository.dart';

class PostMoodImage {
  final MoodTrackerRepository repository;

  PostMoodImage({required this.repository});

  Future<String> execute({required File image, required int userId}) {
    return repository.postMoodImage(image: image, userId: userId);
  }
}
