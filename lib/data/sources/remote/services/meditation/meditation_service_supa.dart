import 'package:flutter/foundation.dart';
import 'package:kalm/data/model/meditation/music_topic_model.dart';
import 'package:kalm/data/model/meditation/playlist_model.dart';
import 'package:kalm/data/model/meditation/playlist_music_item_model.dart';
import 'package:kalm/data/model/meditation/rounded_image_model.dart';
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:supabase/supabase.dart';

class MeditationServiceSupa {
  final client = SupabaseClient(
      ConfigEnvironments.getEnvironments(), ConfigEnvironments.getPublicKey());

  Future<List<Playlist>> fetchAllPlaylist({
    required int userId,
  }) async {
    try {
      final response = await client.from('playlists').select().execute();
      if (response.status! >= 200 && response.status! <= 299) {
        final playlistsMapData = response.data as List<dynamic>;

        final playlistsData =
            await Future.wait<Playlist>(playlistsMapData.map((playlist) async {
          final topicData = await getTopic(topicId: playlist['topic_id']);
          final playlistMusicsData =
              await getMusicPlaylist(playlistId: playlist['id']);

          return Playlist(
            id: playlist['id'] as int?,
            topicId: playlist['topic_id'] as String?,
            topic: topicData,
            name: playlist['name'] as String?,
            description: playlist['description'] as String?,
            quantity: playlist['banyak_lagu'] as String?,
            roundedImage: RoundedImage(url: playlist['image']),
            squaredImage: RoundedImage(thumbnail: playlist['thumbnail']),
            playlistMusicItems: playlistMusicsData,
          );
        }));

        return playlistsData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<Topic> getTopic({required int topicId}) async {
    try {
      final response = await client
          .from('playlist_topic')
          .select()
          .eq('id', topicId)
          .execute();
      if (response.status! >= 200 && response.status! <= 299) {
        final topicMapData = response.data as List<dynamic>;

        final topicData = Topic(
          id: topicMapData.first['id'] as int?,
          name: topicMapData.first['name'] as String?,
        );

        return topicData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<List<PlaylistMusicItem>> getMusicPlaylist(
      {required int playlistId}) async {
    try {
      final response = await client
          .from('musics')
          .select()
          .eq('playlist_id', playlistId)
          .execute();
      if (response.status! >= 200 && response.status! <= 299) {
        final musicsMapData = response.data as List<dynamic>;

        final musicsData = musicsMapData.map((music) {
          return PlaylistMusicItem(
            id: music['id'] as int?,
            playlistId: music['playlist_id'] as String?,
            duration: music['duration'] as String?,
            musicUrl: music['music_url'] as String?,
            name: music['name'] as String?,
            roundedImage: RoundedImage(url: music['image'] as String?),
            squaredImage:
                RoundedImage(thumbnail: music['thumbnail'] as String?),
          );
        }).toList();

        return musicsData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<List<Playlist>> fetchPlaylistByCategory({
    required int userId,
    required String category,
  }) async {
    try {
      final response = await client
          .from('playlists')
          .select()
          .eq('topic_id', category)
          .execute();
      if (response.status! >= 200 && response.status! <= 299) {
        final playlistsMapData = response.data as List<dynamic>;

        final playlistsData =
            await Future.wait<Playlist>(playlistsMapData.map((playlist) async {
          final topicData = await getTopic(topicId: playlist['topic_id']);
          final playlistMusicsData =
              await getMusicPlaylist(playlistId: playlist['id']);

          return Playlist(
            id: playlist['id'] as int?,
            topicId: playlist['topic_id'] as String?,
            topic: topicData,
            name: playlist['name'] as String?,
            description: playlist['description'] as String?,
            quantity: playlist['banyak_lagu'] as String,
            roundedImage: RoundedImage(url: playlist['image'] as String?),
            squaredImage:
                RoundedImage(thumbnail: playlist['thumbnail'] as String?),
            playlistMusicItems: playlistMusicsData,
          );
        }));

        return playlistsData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<Playlist> fetchPlaylistById({
    required int userId,
    required int playlistId,
  }) async {
    try {
      final response = await client
          .from('playlists')
          .select()
          .eq('id', playlistId)
          .execute();
      if (response.status! >= 200 && response.status! <= 299) {
        final playlistDetailMapData = response.data as List<dynamic>;
        final topicData =
            await getTopic(topicId: playlistDetailMapData.first['topic_id']);
        final playlistMusicsData = await getMusicPlaylist(
            playlistId: playlistDetailMapData.first['id']);

        final playlistDetailData = Playlist(
          id: playlistDetailMapData.first['id'] as int?,
          topicId: playlistDetailMapData.first['topic_id'] as String?,
          topic: topicData,
          name: playlistDetailMapData.first['name'] as String?,
          description: playlistDetailMapData.first['description'] as String?,
          quantity: playlistDetailMapData.first['banyak_lagu'] as String?,
          roundedImage: RoundedImage(
              url: playlistDetailMapData.first['image'] as String?),
          squaredImage: RoundedImage(
              thumbnail: playlistDetailMapData.first['thumbnail'] as String?),
          playlistMusicItems: playlistMusicsData,
        );

        return playlistDetailData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }
}

final meditationServiceSupa = MeditationServiceSupa();