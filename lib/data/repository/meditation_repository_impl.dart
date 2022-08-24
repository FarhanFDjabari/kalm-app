import 'package:dartz/dartz.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/meditation/meditation_service.dart';
import 'package:kalm/domain/entity/meditation/playlist_entity.dart';
import 'package:kalm/domain/repository/meditation_repository.dart';

class MeditationRepositoryImpl extends MeditationRepository {
  @override
  Future<Either<String, List<PlaylistEntity>>> getAllPlaylist(
      {required int userId}) async {
    final client = await meditationClient();
    final response = client.fetchAllPlaylist(userId: userId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.playlists!.map((e) => e.toEntity()).toList());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, PlaylistEntity>> getPlaylistDetail(
      {required int userId, required int playlistId}) async {
    final client = await meditationClient();
    final response =
        client.fetchPlaylistById(userId: userId, playlistId: playlistId);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.playlist!.toEntity());
    } else {
      return Left(result.message);
    }
  }

  @override
  Future<Either<String, List<PlaylistEntity>>> getPlaylistsByCategory(
      {required int userId, required String category}) async {
    final client = await meditationClient();
    final response =
        client.fetchPlaylistByCategory(userId: userId, category: category);
    final result = await response.validateStatus().handleError((onError) {
      return Left(onError.toString());
    });
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return Right(result.data!.playlists!.map((e) => e.toEntity()).toList());
    } else {
      return Left(result.message);
    }
  }
}
