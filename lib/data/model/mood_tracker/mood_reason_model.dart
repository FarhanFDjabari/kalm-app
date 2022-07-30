import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_reason_entity.dart';

class MoodReason extends Equatable implements ModelFactory {
  const MoodReason({
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

  factory MoodReason.fromJson(Map<String, dynamic> json) => MoodReason(
        id: json["id"],
        reason: json["reason"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        moodTrackerId: json["mood_tracker_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reason": reason,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "mood_tracker_id": moodTrackerId,
      };

  MoodReasonEntity toEntity() {
    return MoodReasonEntity(
      id: id,
      moodTrackerId: moodTrackerId,
      createdAt: createdAt,
      reason: reason,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        reason,
        createdAt,
        updatedAt,
        moodTrackerId,
      ];
}
