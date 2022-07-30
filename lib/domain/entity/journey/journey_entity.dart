import 'package:equatable/equatable.dart';
import 'package:kalm/domain/entity/meditation/rounded_image_entity.dart';

class JourneyEntity extends Equatable {
  const JourneyEntity({
    required this.id,
    required this.title,
    required this.author,
    this.urutan,
    this.name,
    required this.finishedProgress,
    required this.totalProgress,
    required this.createdAt,
    required this.updatedAt,
    required this.description2,
    required this.image,
  });

  final int id;
  final int finishedProgress;
  final int totalProgress;
  final String title;
  final String author;
  final String? urutan;
  final String? name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String description2;
  final RoundedImageEntity image;

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        urutan,
        finishedProgress,
        totalProgress,
        name,
        createdAt,
        updatedAt,
        description2,
        image,
      ];
}
