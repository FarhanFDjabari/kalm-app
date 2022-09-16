import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kalm/data/sources/local/hive_constants.dart';
import 'package:kalm/data/sources/local/hive_keys.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/meditation/meditation_service_supa.dart';
import 'package:kalm/domain/entity/meditation/playlist_entity.dart';
import 'package:kalm/domain/entity/meditation/playlist_music_item_entity.dart';
import 'package:kalm/domain/repository/meditation_repository.dart';

class MeditationRepositoryImpl extends MeditationRepository {
  @override
  Future<Either<String, List<PlaylistEntity>>> getAllPlaylist(
      {required int userId}) async {
    try {
      final client = meditationServiceSupa;
      final result = await client.fetchAllPlaylist(userId: userId);

      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, PlaylistEntity>> getPlaylistDetail(
      {required int userId, required int playlistId}) async {
    try {
      final client = meditationServiceSupa;
      final result = await client.fetchPlaylistById(
          userId: userId, playlistId: playlistId);

      return Right(result.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<PlaylistEntity>>> getPlaylistsByCategory(
      {required int userId, required String category}) async {
    try {
      final client = meditationServiceSupa;
      final result = await client.fetchPlaylistByCategory(
          userId: userId, category: category);

      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<PlaylistEntity>>> getRecommendedPlaylists(
      {required int moodPoint}) async {
    try {
      final client = meditationServiceSupa;
      final result = await client.getRecomendedPlaylist(moodPoint: moodPoint);

      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<bool> saveMusicItem({required PlaylistMusicItemEntity music}) async {
    try {
      final Box<PlaylistMusicItemEntity> storageBox =
          Hive.box(HiveConstants.MUSICS);
      await storageBox.add(music);
      return true;
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }

  @override
  Future<Either<String, List<PlaylistMusicItemEntity>>> getSavedMusics() async {
    try {
      final storageBox =
          Hive.box<PlaylistMusicItemEntity>(HiveConstants.MUSICS);
      final savedMusics = storageBox.values.toList();
      return Right(savedMusics);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
