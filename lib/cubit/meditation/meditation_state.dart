part of 'meditation_cubit.dart';

@immutable
abstract class MeditationState {}

class MeditationInitial extends MeditationState {}

class MeditationLoading extends MeditationState {}

class MeditationPlaylistLoaded extends MeditationState {
  final List<Playlist> playlistList;

  MeditationPlaylistLoaded(this.playlistList);
}

class DetailPlaylistLoaded extends MeditationState {
  final Playlist playlist;

  DetailPlaylistLoaded(this.playlist);
}

class MeditationLoadError extends MeditationState {
  final String errorMessage;

  MeditationLoadError(this.errorMessage);
}

class MeditationAudioStateChange extends MeditationState {}
