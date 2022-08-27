import 'package:flutter/foundation.dart';
import 'package:kalm/data/model/meditation/music_topic_model.dart';
import 'package:kalm/data/model/meditation/playlist_model.dart';
import 'package:kalm/data/model/meditation/playlist_music_item_model.dart';
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:supabase/supabase.dart';

class MeditationServiceSupa {
  final client = SupabaseClient(
      ConfigEnvironments.getEnvironments(), ConfigEnvironments.getPublicKey());

  Future<List<Playlist>> fetchAllPlaylist({
    required int userId,
  }) async {
    final response = await client.from('playlists').select().execute();
    if (response.status! >= 200 && response.status! <= 299) {
      final playlistsMapData = response.data as List<Map<String, dynamic>>;

      final playlistsData =
          await Future.wait<Playlist>(playlistsMapData.map((playlist) async {
        final topicData = await getTopic(topicId: playlist['topic_id']);
        final playlistMusicsData =
            await getMusicPlaylist(playlistId: playlist['id']);

        return Playlist(
          id: playlist['id'],
          topicId: playlist['topic_id'],
          topic: topicData,
          name: playlist['name'],
          description: playlist['description'],
          quantity: playlist['banyak_lagu'],
          roundedImage: playlist['image'],
          squaredImage: playlist['thumbnail'],
          playlistMusicItems: playlistMusicsData,
        );
      }));

      return playlistsData;
    }
    throw ErrorDescription(response.error!.message);
  }

  Future<Topic> getTopic({required int topicId}) async {
    final response = await client
        .from('playlist_topic')
        .select()
        .eq('id', topicId)
        .execute();
    if (response.status! >= 200 && response.status! <= 299) {
      final topicMapData = response.data as List<Map<String, dynamic>>;

      final topicData = Topic(
        id: topicMapData.first['id'],
        name: topicMapData.first['name'],
      );

      return topicData;
    }
    throw ErrorDescription(response.error!.message);
  }

  Future<List<PlaylistMusicItem>> getMusicPlaylist(
      {required int playlistId}) async {
    final response = await client
        .from('musics')
        .select()
        .eq('playlist_id', playlistId)
        .execute();
    if (response.status! >= 200 && response.status! <= 299) {
      final musicsMapData = response.data as List<Map<String, dynamic>>;

      final musicsData = musicsMapData.map((music) {
        return PlaylistMusicItem(
          id: music['id'],
          playlistId: music['playlist_id'],
          duration: music['duration'],
          musicUrl: music['music_url'],
          name: music['name'],
          roundedImage: music['image'],
          squaredImage: music['thumbnail'],
        );
      }).toList();

      return musicsData;
    }
    throw ErrorDescription(response.error!.message);
  }

  Future<List<Playlist>> fetchPlaylistByCategory({
    required int userId,
    required String category,
  }) async {
    final response = await client
        .from('playlists')
        .select()
        .eq('topic_id', category)
        .execute();
    if (response.status! >= 200 && response.status! <= 299) {
      final playlistsMapData = response.data as List<Map<String, dynamic>>;

      final playlistsData =
          await Future.wait<Playlist>(playlistsMapData.map((playlist) async {
        final topicData = await getTopic(topicId: playlist['topic_id']);
        final playlistMusicsData =
            await getMusicPlaylist(playlistId: playlist['id']);

        return Playlist(
          id: playlist['id'],
          topicId: playlist['topic_id'],
          topic: topicData,
          name: playlist['name'],
          description: playlist['description'],
          quantity: playlist['banyak_lagu'],
          roundedImage: playlist['image'],
          squaredImage: playlist['thumbnail'],
          playlistMusicItems: playlistMusicsData,
        );
      }));

      return playlistsData;
    }
    throw ErrorDescription(response.error!.message);
  }

  Future<Playlist> fetchPlaylistById({
    required int userId,
    required int playlistId,
  }) async {
    final response =
        await client.from('playlists').select().eq('id', playlistId).execute();
    if (response.status! >= 200 && response.status! <= 299) {
      final playlistDetailMapData = response.data as List<Map<String, dynamic>>;
      final topicData =
          await getTopic(topicId: playlistDetailMapData.first['topic_id']);
      final playlistMusicsData =
          await getMusicPlaylist(playlistId: playlistDetailMapData.first['id']);

      final playlistDetailData = Playlist(
        id: playlistDetailMapData.first['id'],
        topicId: playlistDetailMapData.first['topic_id'],
        topic: topicData,
        name: playlistDetailMapData.first['name'],
        description: playlistDetailMapData.first['description'],
        quantity: playlistDetailMapData.first['banyak_lagu'],
        roundedImage: playlistDetailMapData.first['image'],
        squaredImage: playlistDetailMapData.first['thumbnail'],
        playlistMusicItems: playlistMusicsData,
      );

      return playlistDetailData;
    }
    throw ErrorDescription(response.error!.message);
  }
}

final meditationServiceSupa = MeditationServiceSupa();
