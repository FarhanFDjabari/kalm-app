import 'package:kalm/domain/entity/meditation/playlist_music_item_entity.dart';
import 'package:kalm/domain/repository/meditation_repository.dart';

class SaveMeditationItem {
  final MeditationRepository repository;

  SaveMeditationItem({required this.repository});

  Future<bool> execute({required PlaylistMusicItemEntity music}) {
    return repository.saveMusicItem(music: music);
  }
}
