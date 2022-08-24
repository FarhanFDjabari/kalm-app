import 'package:hive/hive.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/entity/meditation/playlist_music_item_entity.dart';
import 'package:kalm/domain/entity/meditation/rounded_image_entity.dart';

class DatabaseAdapter {
  void registerAdapter() {
    Hive.registerAdapter<UserEntity>(UserEntityAdapter());
    Hive.registerAdapter<PlaylistMusicItemEntity>(
        PlaylistMusicItemEntityAdapter());
    Hive.registerAdapter<RoundedImageEntity>(RoundedImageEntityAdapter());
  }
}
