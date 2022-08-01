import 'package:bloc/bloc.dart';
import 'package:kalm/data/sources/remote/services/moodtracker/mood_tracker_service.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_daily_insight_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_home_entity.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_weekly_insight_entity.dart';
import 'package:kalm/domain/usecases/mood_tracker/get_daily_mood_insight.dart';
import 'package:kalm/domain/usecases/mood_tracker/get_mood_tracker_home_data.dart';
import 'package:kalm/domain/usecases/mood_tracker/get_weekly_mood_insight.dart';
import 'package:kalm/domain/usecases/mood_tracker/post_mood.dart';
import 'package:meta/meta.dart';

part 'mood_tracker_state.dart';

class MoodTrackerCubit extends Cubit<MoodTrackerState> {
  MoodTrackerCubit({
    required this.getDailyMoodInsight,
    required this.getMoodTrackerHomeData,
    required this.getWeeklyMoodInsight,
    required this.postMood,
  }) : super(MoodTrackerInitial());

  final GetDailyMoodInsight getDailyMoodInsight;
  final GetMoodTrackerHomeData getMoodTrackerHomeData;
  final GetWeeklyMoodInsight getWeeklyMoodInsight;
  final PostMood postMood;

  void fetchMoodTrackerHome(int userId) async {
    emit(MoodTrackerLoading());
    try {
      final result = await getMoodTrackerHomeData.execute(userId: userId);

      result.fold(
        (l) => emit(MoodTrackerError(l)),
        (r) => emit(MoodTrackerLoadSuccess(r)),
      );
    } catch (error) {
      emit(MoodTrackerError(error.toString()));
    }
  }

  void fetchWeeklyMoodInsight(int userId) async {
    emit(MoodTrackerLoading());
    try {
      final result = await getWeeklyMoodInsight.execute(userId: userId);

      result.fold(
        (l) => emit(MoodTrackerError(l)),
        (r) => emit(WeeklyInsightLoaded(r)),
      );
    } catch (error) {
      emit(MoodTrackerError(error.toString()));
    }
  }

  void fetchDailyMoodInsight(int userId) async {
    emit(MoodTrackerLoading());
    try {
      final result = await getDailyMoodInsight.execute(userId: userId);

      result.fold(
        (l) => emit(MoodTrackerError(l)),
        (r) => emit(DailyInsightLoaded(r)),
      );
    } catch (error) {
      emit(MoodTrackerError(error.toString()));
    }
  }

  void postMoodTracker(int userId, int mood, List<String> reasons) async {
    emit(MoodTrackerLoading());
    try {
      final result =
          await postMood.execute(userId: userId, mood: mood, reasons: reasons);

      result.fold(
        (l) => emit(MoodTrackerError(l)),
        (r) => emit(MoodTrackerSaved()),
      );
    } catch (error) {
      emit(MoodTrackerError(error.toString()));
    }
  }
}
