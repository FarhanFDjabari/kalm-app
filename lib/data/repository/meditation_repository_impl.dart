import 'package:dartz/dartz.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/meditation/meditation_service.dart';
import 'package:kalm/domain/entity/meditation/playlist_entity.dart';
import 'package:kalm/domain/repository/meditation_repository.dart';

class MeditationRepositoryImpl extends MeditationRepository {
  @override
  Future<Either<String, List<PlaylistEntity>>> getAllPlaylist(
      {required int userId}) async {
    await meditationClient().then((client) {
      client.fetchAllPlaylist(userId: userId).validateStatus().then((response) {
        return Right(
            response.data!.playlists!.map((e) => e.toEntity()).toList());
      });
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, PlaylistEntity>> getPlaylistDetail(
      {required int userId, required int playlistId}) async {
    await meditationClient().then((client) {
      client
          .fetchPlaylistById(userId: userId, playlistId: playlistId)
          .validateStatus()
          .then((response) {
        return Right(response.data!.playlist!.toEntity());
      });
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }

  @override
  Future<Either<String, List<PlaylistEntity>>> getPlaylistsByCategory(
      {required int userId, required String category}) async {
    await meditationClient().then((client) {
      client
          .fetchPlaylistByCategory(userId: userId, category: category)
          .validateStatus()
          .then((response) {
        return Right(
            response.data!.playlists!.map((e) => e.toEntity()).toList());
      });
    }).handleError((onError) {
      return Left(onError.toString());
    });
    return Left("Unknown Error");
  }
}
