import 'package:kalm/data/sources/remote/services/meditation/meditation_service.dart';
import 'package:kalm/domain/entity/meditation/playlist_entity.dart';
import 'package:kalm/domain/repository/meditation_repository.dart';

class MeditationRepositoryImpl extends MeditationRepository {
  final MeditationService service;

  MeditationRepositoryImpl({required this.service});

  @override
  Future<List<PlaylistEntity>> getAllPlaylist({required int userId}) {
    // TODO: implement getAllPlaylist
    throw UnimplementedError();
  }

  @override
  Future<PlaylistEntity> getPlaylistDetail(
      {required int userId, required int playlistId}) {
    // TODO: implement getPlaylistDetail
    throw UnimplementedError();
  }

  @override
  Future<List<PlaylistEntity>> getPlaylistsByCategory(
      {required int userId, required String category}) {
    // TODO: implement getPlaylistsByCategory
    throw UnimplementedError();
  }
}
