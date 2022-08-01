part of 'mood_tracker_cubit.dart';

@immutable
abstract class MoodTrackerState {}

class MoodTrackerInitial extends MoodTrackerState {}

class MoodTrackerLoadSuccess extends MoodTrackerState {
  final MoodTrackerHomeEntity moodTrackerData;

  MoodTrackerLoadSuccess(this.moodTrackerData);
}

class MoodTrackerError extends MoodTrackerState {
  final String errorMessage;

  MoodTrackerError(this.errorMessage);
}

class MoodTrackerLoading extends MoodTrackerState {}

class DailyInsightLoaded extends MoodTrackerState {
  final MoodTrackerDailyInsightEntity dailyInsightData;

  DailyInsightLoaded(this.dailyInsightData);
}

class WeeklyInsightLoaded extends MoodTrackerState {
  final MoodTrackerWeeklyInsightEntity weeklyInsightData;

  WeeklyInsightLoaded(this.weeklyInsightData);
}

class MoodTrackerSaved extends MoodTrackerState {}
