import 'package:dartz/dartz.dart';
import 'package:kalm/domain/entity/meditation/playlist_music_item_entity.dart';
import 'package:kalm/domain/repository/meditation_repository.dart';

class GetSavedMeditations {
  final MeditationRepository repository;

  GetSavedMeditations({required this.repository});

  Future<Either<String, List<PlaylistMusicItemEntity>>> execute() {
    return repository.getSavedMusics();
  }
}
