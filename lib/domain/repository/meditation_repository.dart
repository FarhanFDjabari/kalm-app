import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/meditation/playlist_entity.dart';
import 'package:kalm/domain/entity/meditation/playlist_music_item_entity.dart';

abstract class MeditationRepository {
  Future<Either<String, List<PlaylistEntity>>> getAllPlaylist(
      {required int userId});
  Future<Either<String, List<PlaylistEntity>>> getPlaylistsByCategory({
    required int userId,
    required String category,
  });
  Future<Either<String, List<PlaylistEntity>>> getRecommendedPlaylists({
    required int moodPoint,
  });
  Future<Either<String, PlaylistEntity>> getPlaylistDetail({
    required int userId,
    required int playlistId,
  });
  Future<bool> saveMusicItem({required PlaylistMusicItemEntity music});
  Future<Either<String, List<PlaylistMusicItemEntity>>> getSavedMusics();
}
