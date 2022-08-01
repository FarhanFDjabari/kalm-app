part of 'journey_cubit.dart';

@immutable
abstract class JourneyState {}

class JourneyInitial extends JourneyState {}

class JourneyLoading extends JourneyState {}

class JourneyQuoteLoadSuccess extends JourneyState {
  final QuoteEntity quoteData;

  JourneyQuoteLoadSuccess(this.quoteData);
}

class JournalPosted extends JourneyState {}

class MeditationTaskPosted extends JourneyState {}

class JourneyLoaded extends JourneyState {
  final List<JourneyEntity> journeyList;

  JourneyLoaded(this.journeyList);
}

class JourneyError extends JourneyState {
  final String errorMessage;

  JourneyError(this.errorMessage);
}

class JourneyDetailLoaded extends JourneyState {
  final DetailJourneyEntity detailJourney;

  JourneyDetailLoaded(this.detailJourney);
}

class JourneyTaskLoaded extends JourneyState {
  final JournalItemEntity journeyTask;

  JourneyTaskLoaded(this.journeyTask);
}

class MeditationTaskLoaded extends JourneyState {
  final MeditationItemEntity meditationTask;

  MeditationTaskLoaded(this.meditationTask);
}
