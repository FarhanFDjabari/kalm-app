import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/meditation/playlist_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class DetailPlaylistModel extends Equatable implements ModelFactory {
  const DetailPlaylistModel({
    this.playlist,
  });

  final Playlist? playlist;

  factory DetailPlaylistModel.fromJson(Map<String, dynamic> json) =>
      DetailPlaylistModel(
        playlist: Playlist.fromJson(json["playlist"]),
      );

  Map<String, dynamic> toJson() => {
        "playlists": playlist,
      };

  @override
  List<Object?> get props => [playlist];
}
