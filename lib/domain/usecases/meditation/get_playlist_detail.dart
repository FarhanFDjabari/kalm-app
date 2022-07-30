import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/meditation/playlist_entity.dart';
import 'package:kalm/domain/repository/meditation_repository.dart';

class GetPlaylistDetail {
  final MeditationRepository repository;

  GetPlaylistDetail({required this.repository});

  Future<Either<String, PlaylistEntity>> execute(
      {required int userId, required int playlistId}) {
    return repository.getPlaylistDetail(userId: userId, playlistId: playlistId);
  }
}
