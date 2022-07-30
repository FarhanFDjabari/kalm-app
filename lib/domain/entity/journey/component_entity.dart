import 'package:equatable/equatable.dart';

class ComponentEntity extends Equatable {
  const ComponentEntity({
    required this.id,
    required this.modelType,
    this.urutan,
    required this.createdAt,
    required this.journeyId,
    this.name,
    required this.isFinished,
  });

  final int id;
  final String modelType;
  final String? urutan;
  final DateTime createdAt;
  final int journeyId;
  final String? name;
  final bool isFinished;

  @override
  List<Object?> get props => [
        id,
        modelType,
        urutan,
        createdAt,
        journeyId,
        name,
        isFinished,
      ];
}
