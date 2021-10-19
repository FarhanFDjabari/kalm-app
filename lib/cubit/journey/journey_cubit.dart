import 'package:bloc/bloc.dart';
import 'package:kalm/model/journey/journey_detail_model.dart';
import 'package:kalm/model/journey/journey_model.dart';
import 'package:kalm/model/journey/journey_task_model.dart';
import 'package:kalm/services/journey/journey_service.dart';
import 'package:meta/meta.dart';

part 'journey_state.dart';

class JourneyCubit extends Cubit<JourneyState> {
  JourneyCubit() : super(JourneyInitial());
  JourneyService journeyService = JourneyService();

  void fetchAllJourney(int userId) async {
    emit(JourneyLoading());
    try {
      final result = await journeyService.fetchAllJourney(userId);
      if (result.success) {
        emit(JourneyLoaded(result.data!.journeys!));
      } else {
        emit(JourneyError(result.message));
      }
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }

  void getJourneyDetail(int userId, int journeyId) async {
    emit(JourneyLoading());
    try {
      final result = await journeyService.getJourneyById(journeyId, userId);
      if (result.success) {
        emit(JourneyDetailLoaded(result.data!.journey));
      } else {
        emit(JourneyError(result.message));
      }
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }

  void getJourneyTask(int userId, int taskId) async {
    emit(JourneyLoading());
    try {
      final result = await journeyService.getJourneyTask(userId, taskId);
      if (result.success) {
        emit(JourneyTaskLoaded(result.data!.item));
      } else {
        emit(JourneyError(result.message));
      }
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }
}
