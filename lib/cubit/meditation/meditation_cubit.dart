import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'meditation_state.dart';

class MeditationCubit extends Cubit<MeditationState> {
  MeditationCubit() : super(MeditationInitial());
}
