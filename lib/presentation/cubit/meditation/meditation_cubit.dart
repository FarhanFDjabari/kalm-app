import 'package:bloc/bloc.dart';
import 'package:kalm/domain/entity/meditation/playlist_entity.dart';
import 'package:kalm/domain/usecases/meditation/get_all_playlist.dart';
import 'package:kalm/domain/usecases/meditation/get_all_playlist_by_category.dart';
import 'package:kalm/domain/usecases/meditation/get_playlist_detail.dart';
import 'package:kalm/domain/usecases/meditation/get_recomended_playlist.dart';
import 'package:meta/meta.dart';

part 'meditation_state.dart';

class MeditationCubit extends Cubit<MeditationState> {
  MeditationCubit({
    required this.getAllPlaylist,
    required this.getAllPlaylistByCategory,
    required this.getPlaylistDetail,
    required this.getRecommendedPlaylist,
  }) : super(MeditationInitial());

  final GetAllPlaylistByCategory getAllPlaylistByCategory;
  final GetAllPlaylist getAllPlaylist;
  final GetPlaylistDetail getPlaylistDetail;
  final GetRecommendedPlaylist getRecommendedPlaylist;

  void fetchAllPlaylist(int userId) async {
    emit(MeditationLoading());
    try {
      final result = await getAllPlaylist.execute(userId: userId);

      result.fold(
        (l) => emit(MeditationLoadError('Error: $l')),
        (r) => emit(MeditationPlaylistLoaded(r)),
      );
    } catch (error) {
      emit(MeditationLoadError('Error: $error'));
    }
  }

  void fetchRecommendedPlaylist(int moodPoint) async {
    emit(MeditationRecommendLoading());
    try {
      final result = await getRecommendedPlaylist.execute(moodPoint: moodPoint);

      result.fold(
        (l) => emit(MeditationLoadError('Error: $l')),
        (r) => emit(MeditationRecommendedPlaylistLoaded(r)),
      );
    } catch (error) {
      emit(MeditationLoadError('Error: $error'));
    }
  }

  void fetchPlaylistByCategory(int userId, String category) async {
    emit(MeditationLoading());
    try {
      final result = await getAllPlaylistByCategory.execute(
          userId: userId, category: category);

      result.fold(
        (l) => emit(MeditationLoadError('Error: $l')),
        (r) => emit(MeditationPlaylistLoaded(r)),
      );
    } catch (error) {
      emit(MeditationLoadError('Error: $error'));
    }
  }

  void fetchPlaylistById(int userId, int playlistId) async {
    emit(MeditationLoading());
    try {
      final result = await getPlaylistDetail.execute(
        userId: userId,
        playlistId: playlistId,
      );

      result.fold(
        (l) => emit(MeditationLoadError('Error: $l')),
        (r) => emit(DetailPlaylistLoaded(r)),
      );
    } catch (error) {
      emit(MeditationLoadError('Error: $error'));
    }
  }
}
