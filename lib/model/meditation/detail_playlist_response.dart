import 'package:kalm/model/meditation/playlist_model.dart';

class DetailPlaylistResponse {
  DetailPlaylistResponse({
    required this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  bool success;
  int? statusCode;
  String? message;
  Data? data;

  factory DetailPlaylistResponse.fromJson(Map<String, dynamic> json) =>
      DetailPlaylistResponse(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["mesage"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "mesage": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.playlist,
  });

  Playlist? playlist;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        playlist: Playlist.fromJson(json["playlist"]),
      );

  Map<String, dynamic> toJson() => {
        "playlists": playlist,
      };
}
