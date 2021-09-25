part of 'meditation_cubit.dart';

@immutable
abstract class MeditationState {}

class MeditationInitial extends MeditationState {}

class MeditationLoading extends MeditationState {}

class MeditationLoaded extends MeditationState {}

class MeditationAudioStateChange extends MeditationState {}
