import 'package:equatable/equatable.dart';

class MoodReasonEntity extends Equatable {
  const MoodReasonEntity({
    required this.id,
    this.reason,
    this.createdAt,
    this.updatedAt,
    required this.moodTrackerId,
  });

  final int id;
  final String? reason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String moodTrackerId;

  @override
  List<Object?> get props => [
        id,
        reason,
        createdAt,
        updatedAt,
        moodTrackerId,
      ];
}
