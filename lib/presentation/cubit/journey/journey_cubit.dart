import 'package:bloc/bloc.dart';
import 'package:kalm/data/model/journey/journal_quote_model.dart';
import 'package:kalm/data/model/journey/journal_task_model.dart';
import 'package:kalm/data/model/journey/journey_detail_model.dart';
import 'package:kalm/data/model/journey/journey_model.dart';
import 'package:kalm/data/model/journey/meditation_task_model.dart';
import 'package:kalm/domain/entity/journey/journal_item_entity.dart';
import 'package:kalm/domain/entity/journey/journey_detail_entity.dart';
import 'package:kalm/domain/entity/journey/journey_entity.dart';
import 'package:kalm/domain/entity/journey/meditation_item_entity.dart';
import 'package:kalm/domain/entity/journey/quote_entity.dart';
import 'package:kalm/domain/usecases/journey/get_all_journey.dart';
import 'package:kalm/domain/usecases/journey/get_journal_task.dart';
import 'package:kalm/domain/usecases/journey/get_journey_detail.dart';
import 'package:kalm/domain/usecases/journey/get_meditation_task.dart';
import 'package:kalm/domain/usecases/journey/get_quote.dart';
import 'package:kalm/domain/usecases/journey/post_journal_task.dart';
import 'package:kalm/domain/usecases/journey/post_meditation_task.dart';
import 'package:meta/meta.dart';

part 'journey_state.dart';

class JourneyCubit extends Cubit<JourneyState> {
  JourneyCubit({
    required this.getAllJourney,
    required this.getJournalTask,
    required this.getJourneyDetailUsecase,
    required this.getMeditationTaskUsecase,
    required this.getQuote,
    required this.postJournalTaskUsecase,
    required this.postMeditationTaskUseCase,
  }) : super(JourneyInitial());

  final GetAllJourney getAllJourney;
  final GetJournalTask getJournalTask;
  final GetJourneyDetail getJourneyDetailUsecase;
  final GetMeditationTask getMeditationTaskUsecase;
  final GetQuote getQuote;
  final PostJournalTask postJournalTaskUsecase;
  final PostMeditationTask postMeditationTaskUseCase;

  void fetchAllJourney(int userId) async {
    emit(JourneyLoading());
    try {
      final result = await getAllJourney.execute(userId: userId);

      result.fold(
        (l) => emit(JourneyError(l)),
        (r) => emit(JourneyLoaded(r)),
      );
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }

  void getJourneyDetail(int userId, int journeyId) async {
    emit(JourneyLoading());
    try {
      final result = await getJourneyDetailUsecase.execute(
          journeyId: journeyId, userId: userId);

      result.fold(
        (l) => emit(JourneyError(l)),
        (r) => emit(JourneyDetailLoaded(r)),
      );
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }

  void getJourneyTask(int userId, int taskId) async {
    emit(JourneyLoading());
    try {
      final result =
          await getJournalTask.execute(userId: userId, taskId: taskId);

      result.fold(
        (l) => emit(JourneyError(l)),
        (r) => emit(JourneyTaskLoaded(r)),
      );
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }

  void postJournalTask(int userId, int journeyId, int componentId,
      List<Map<String, dynamic>> answers) async {
    emit(JourneyLoading());
    try {
      final result = await postJournalTaskUsecase.execute(
          userId: userId,
          componentId: componentId,
          journeyId: journeyId,
          answers: answers);

      result.fold(
        (l) => emit(JourneyError(l)),
        (r) => emit(JournalPosted()),
      );
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }

  void getJourneyQuote(int userId, int journeyId) async {
    emit(JourneyLoading());
    try {
      final result =
          await getQuote.execute(userId: userId, journeyId: journeyId);

      result.fold(
        (l) => emit(JourneyError(l)),
        (r) => emit(JourneyQuoteLoadSuccess(r)),
      );
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }

  void getMeditationTask(int userId, int taskId) async {
    emit(JourneyLoading());
    try {
      final result = await getMeditationTaskUsecase.execute(
          userId: userId, taskId: taskId);

      result.fold(
        (l) => emit(JourneyError(l)),
        (r) => emit(MeditationTaskLoaded(r)),
      );
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }

  void postMeditationTask(int userId, int componentId, int journeyId) async {
    emit(JourneyLoading());
    try {
      final result = await postMeditationTaskUseCase.execute(
          userId: userId, componentId: componentId, journeyId: journeyId);

      result.fold(
        (l) => emit(JourneyError(l)),
        (r) => emit(MeditationTaskPosted()),
      );
    } catch (error) {
      emit(JourneyError(error.toString()));
    }
  }
}
