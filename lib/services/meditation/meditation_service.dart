import 'package:dio/dio.dart';
import 'package:kalm/model/meditation/detail_playlist_response.dart';
import 'package:kalm/model/meditation/playlist_model.dart';

class MeditationService {
  static MeditationService? _service;

  MeditationService._createObject();

  factory MeditationService() => _service ?? MeditationService._createObject();
  Dio _dio = Dio();
  final String BASE_URL = "http://calma.com-indo.com/";

  Future<PlaylistModel> fetchAllPlaylist({required int userId}) async {
    try {
      Response _response = await _dio.get(
        BASE_URL + 'api/v1/playlists',
        queryParameters: {"user_id": userId},
      );
      PlaylistModel _playlist = PlaylistModel.fromJson(_response.data);
      return _playlist;
    } on DioError catch (error) {
      PlaylistModel _errorData = PlaylistModel.fromJson(error.response?.data);
      return _errorData;
    }
  }

  Future<PlaylistModel> fetchPlaylistByCategory(
      {required int userId, required String category}) async {
    try {
      Response _response = await _dio.get(
        BASE_URL + 'api/v1/playlists/category/$category',
        queryParameters: {"user_id": userId},
      );
      PlaylistModel _playlist = PlaylistModel.fromJson(_response.data);
      return _playlist;
    } on DioError catch (error) {
      PlaylistModel _errorData = PlaylistModel.fromJson(error.response?.data);
      return _errorData;
    }
  }

  Future<DetailPlaylistResponse> fetchPlaylistById(
      {required int userId, required int playlistId}) async {
    try {
      Response _response = await _dio.get(
        BASE_URL + 'api/v1/playlists/$playlistId',
        queryParameters: {"user_id": userId},
      );
      DetailPlaylistResponse _detailPlaylist =
          DetailPlaylistResponse.fromJson(_response.data);
      return _detailPlaylist;
    } on DioError catch (error) {
      DetailPlaylistResponse _errorData =
          DetailPlaylistResponse.fromJson(error.response?.data);
      return _errorData;
    }
  }
}
