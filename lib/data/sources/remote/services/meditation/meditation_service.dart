import 'package:dio/dio.dart';
import 'package:kalm/data/model/meditation/detail_playlist_model.dart';
import 'package:kalm/data/model/meditation/playlist_model.dart';
import 'package:kalm/data/sources/remote/interceptor/dio.dart';
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:kalm/data/sources/remote/wrapper/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'meditation_service.g.dart';

@RestApi()
abstract class MeditationService {
  factory MeditationService(Dio dio, {String baseUrl}) = _MeditationService;

  static Future<MeditationService> create({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    final defHeader = Map<String, dynamic>.from(headers);
    // defHeader["Accept"] = "application/json";

    return MeditationService(
      await AppDio().getDIO(
          headers: defHeader,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout),
      baseUrl: ConfigEnvironments.getEnvironments().toString(),
    );
  }

  @GET('api/v1/playlists')
  Future<ApiResponse<PlaylistModel>> fetchAllPlaylist({
    @Query("user_id") required int userId,
  });

  @GET('api/v1/playlists/category/{category}')
  Future<ApiResponse<PlaylistModel>> fetchPlaylistByCategory({
    @Query("user_id") required int userId,
    @Path("category") required String category,
  });

  @GET('api/v1/playlists/{playlistId}')
  Future<ApiResponse<DetailPlaylistModel>> fetchPlaylistById({
    @Query("user_id") required int userId,
    @Path("playlistId") required int playlistId,
  });
}

final meditationClient = MeditationService.create;
