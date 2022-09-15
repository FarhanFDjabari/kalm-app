import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/meditation/playlist_entity.dart';
import 'package:kalm/domain/repository/meditation_repository.dart';

class GetRecommendedPlaylist {
  final MeditationRepository repository;

  GetRecommendedPlaylist({required this.repository});

  Future<Either<String, List<PlaylistEntity>>> execute(
      {required int moodPoint}) {
    return repository.getRecommendedPlaylists(moodPoint: moodPoint);
  }
}
