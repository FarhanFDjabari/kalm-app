import 'package:bloc/bloc.dart';
import 'package:kalm/model/meditation/playlist_model.dart';
import 'package:kalm/services/meditation/meditation_service.dart';
import 'package:meta/meta.dart';

part 'meditation_state.dart';

class MeditationCubit extends Cubit<MeditationState> {
  MeditationCubit() : super(MeditationInitial());
  MeditationService meditationService = MeditationService();

  void fetchAllPlaylist(int userId) async {
    emit(MeditationLoading());
    try {
      final result = await meditationService.fetchAllPlaylist(userId: userId);
      if (result.success) {
        emit(MeditationPlaylistLoaded(result.data!.playlists!));
      } else {
        emit(MeditationLoadError('Error: ${result.message}'));
      }
    } catch (error) {
      emit(MeditationLoadError('Error: $error'));
    }
  }

  void fetchPlaylistById(int userId, int playlistId) async {
    emit(MeditationLoading());
    try {
      final result = await meditationService.fetchPlaylistById(
        userId: userId,
        playlistId: playlistId,
      );
      if (result.success) {
        emit(DetailPlaylistLoaded(result.data!.playlist!));
      } else {
        emit(MeditationLoadError('Error: ${result.message}'));
      }
    } catch (error) {
      emit(MeditationLoadError('Error: $error'));
    }
  }
}
