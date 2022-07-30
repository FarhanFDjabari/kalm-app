import 'package:kalm/domain/entity/meditation/playlist_entity.dart';

abstract class MeditationRepository {
  Future<List<PlaylistEntity>> getAllPlaylist({required int userId});
  Future<List<PlaylistEntity>> getPlaylistsByCategory({
    required int userId,
    required String category,
  });
  Future<PlaylistEntity> getPlaylistDetail({
    required int userId,
    required int playlistId,
  });
}
