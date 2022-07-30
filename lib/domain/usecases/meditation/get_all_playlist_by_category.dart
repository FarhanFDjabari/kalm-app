import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/meditation/playlist_entity.dart';
import 'package:kalm/domain/repository/meditation_repository.dart';

class GetAllPlaylistByCategory {
  final MeditationRepository repository;

  GetAllPlaylistByCategory({required this.repository});

  Future<Either<String, List<PlaylistEntity>>> execute(
      {required int userId, required String category}) {
    return repository.getPlaylistsByCategory(
        userId: userId, category: category);
  }
}
