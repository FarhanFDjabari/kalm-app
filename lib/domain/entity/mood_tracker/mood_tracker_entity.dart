import 'package:equatable/equatable.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_reason_entity.dart';

class MoodTrackerEntity extends Equatable {
  const MoodTrackerEntity({
    required this.index,
    required this.createdAt,
    required this.updatedAt,
    required this.mood,
    this.reasons,
  });

  final int index;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int mood;
  final List<MoodReasonEntity>? reasons;

  @override
  List<Object?> get props => [index, createdAt, updatedAt, mood, reasons];
}
