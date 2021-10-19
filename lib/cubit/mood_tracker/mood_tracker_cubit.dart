import 'package:bloc/bloc.dart';
import 'package:kalm/model/mood_tracker/mood_tracker_daily_response.dart';
import 'package:kalm/model/mood_tracker/mood_tracker_home_response.dart';
import 'package:kalm/model/mood_tracker/mood_tracker_weekly_response.dart';
import 'package:kalm/services/moodtracker/mood_tracker_service.dart';
import 'package:meta/meta.dart';

part 'mood_tracker_state.dart';

class MoodTrackerCubit extends Cubit<MoodTrackerState> {
  MoodTrackerCubit() : super(MoodTrackerInitial());
  MoodTrackerService moodTrackerService = MoodTrackerService();

  void fetchMoodTrackerHome(int userId) async {
    emit(MoodTrackerLoading());
    try {
      final result = await moodTrackerService.fetchHomeData(userId);
      if (result.success) {
        emit(MoodTrackerLoadSuccess(result.data!));
      } else {
        emit(MoodTrackerError(result.message));
      }
    } catch (error) {
      emit(MoodTrackerError(error.toString()));
    }
  }

  void fetchWeeklyMoodInsight(int userId) async {
    emit(MoodTrackerLoading());
    try {
      final result = await moodTrackerService.fetchWeeklyMoodInsight(userId);
      if (result.success) {
        emit(WeeklyInsightLoaded(result.data!));
      } else {
        emit(MoodTrackerError(result.message));
      }
    } catch (error) {
      emit(MoodTrackerError(error.toString()));
    }
  }

  void fetchDailyMoodInsight(int userId) async {
    emit(MoodTrackerLoading());
    try {
      final result = await moodTrackerService.fetchDailyMoodInsight(userId);
      if (result.success) {
        emit(DailyInsightLoaded(result.data!));
      } else {
        emit(MoodTrackerError(result.message));
      }
    } catch (error) {
      emit(MoodTrackerError(error.toString()));
    }
  }

  void postMoodTracker(int userId, int mood, List<String> reasons) async {
    emit(MoodTrackerLoading());
    try {
      final result =
          await moodTrackerService.postMoodTracker(userId, mood, reasons);
      if (result.success != null) {
        emit(MoodTrackerSaved());
      } else {
        emit(MoodTrackerError(result.message!));
      }
    } catch (error) {
      emit(MoodTrackerError(error.toString()));
    }
  }
}
