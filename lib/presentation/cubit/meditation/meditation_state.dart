part of 'meditation_cubit.dart';

@immutable
abstract class MeditationState {}

class MeditationInitial extends MeditationState {}

class MeditationLoading extends MeditationState {}

class MeditationRecommendLoading extends MeditationState {}

class MeditationPlaylistLoaded extends MeditationState {
  final List<PlaylistEntity> playlistList;

  MeditationPlaylistLoaded(this.playlistList);
}

class MeditationRecommendedPlaylistLoaded extends MeditationState {
  final List<PlaylistEntity> playlistList;

  MeditationRecommendedPlaylistLoaded(this.playlistList);
}

class DetailPlaylistLoaded extends MeditationState {
  final PlaylistEntity playlist;

  DetailPlaylistLoaded(this.playlist);
}

class MeditationLoadError extends MeditationState {
  final String errorMessage;

  MeditationLoadError(this.errorMessage);
}

class MeditationAudioStateChange extends MeditationState {}
