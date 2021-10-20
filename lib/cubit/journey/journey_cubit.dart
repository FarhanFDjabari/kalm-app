import 'package:bloc/bloc.dart';
import 'package:kalm/model/journey/journal_quote_response.dart';
import 'package:kalm/model/journey/journal_task_model.dart';
import 'package:kalm/model/journey/journey_detail_model.dart';
import 'package:kalm/model/journey/journey_model.dart';
import 'package:kalm/model/journey/meditation_task_model.dart';
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
      final result = await journeyService.getJournalTask(userId, taskId);
      if (result.success) {
        emit(JourneyTaskLoaded(result.data!.item));
      } else {
        emit(JourneyError(result.message));
      }
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }

  void postJournalTask(
      int userId, int journeyId, int componentId, List answers) async {
    emit(JourneyLoading());
    try {
      final result = await journeyService.postJournalTask(
          userId, componentId, journeyId, answers);
      if (result.success) {
        emit(JournalPosted());
      } else {
        emit(JourneyError(result.message));
      }
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }

  void getJourneyQuote(int userId, int journeyId) async {
    emit(JourneyLoading());
    try {
      final result = await journeyService.getJourneyQuote(userId, journeyId);
      if (result.success) {
        emit(JourneyQuoteLoadSuccess(result.data!.quote));
      } else {
        emit(JourneyError(result.message));
      }
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }

  void getMeditationTask(int userId, int taskId) async {
    emit(JourneyLoading());
    try {
      final result = await journeyService.getMeditationTask(userId, taskId);
      if (result.success) {
        emit(MeditationTaskLoaded(result.data!.item));
      } else {
        emit(JourneyError(result.message));
      }
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }

  void postMeditationTask(int userId, int componentId, int journeyId) async {
    emit(JourneyLoading());
    try {
      final result = await journeyService.postMeditationTask(
          userId, componentId, journeyId);
      if (result.success) {
        emit(MeditationTaskPosted());
      } else {
        emit(JourneyError(result.message));
      }
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }
}
