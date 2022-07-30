import 'package:equatable/equatable.dart';

class MoodTrackerPostEntity extends Equatable {
  const MoodTrackerPostEntity({
    this.data,
  });

  final List<dynamic>? data;

  @override
  List<Object?> get props => [data];
}
