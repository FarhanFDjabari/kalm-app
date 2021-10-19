part of 'journey_cubit.dart';

@immutable
abstract class JourneyState {}

class JourneyInitial extends JourneyState {}

class JourneyLoading extends JourneyState {}

class JourneyLoaded extends JourneyState {
  final List<Journey> journeyList;

  JourneyLoaded(this.journeyList);
}

class JourneyError extends JourneyState {
  final String errorMessage;

  JourneyError(this.errorMessage);
}

class JourneyDetailLoaded extends JourneyState {
  final DetailJourney detailJourney;

  JourneyDetailLoaded(this.detailJourney);
}

class JourneyTaskLoaded extends JourneyState {
  final Item journeyTask;

  JourneyTaskLoaded(this.journeyTask);
}
