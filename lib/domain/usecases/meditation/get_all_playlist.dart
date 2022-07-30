import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/meditation/playlist_entity.dart';
import 'package:kalm/domain/repository/meditation_repository.dart';

class GetAllPlaylist {
  final MeditationRepository repository;

  GetAllPlaylist({required this.repository});

  Future<Either<String, List<PlaylistEntity>>> execute({required int userId}) {
    return repository.getAllPlaylist(userId: userId);
  }
}
