import 'package:equatable/equatable.dart';
import 'package:kalm/domain/entity/journey/component_entity.dart';
import 'package:kalm/domain/entity/meditation/rounded_image_entity.dart';

class DetailJourneyEntity extends Equatable {
  const DetailJourneyEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.createdAt,
    required this.description2,
    required this.image,
    this.components,
    required this.isFinished,
  });

  final int id;
  final String title;
  final String author;
  final DateTime createdAt;
  final String description2;
  final RoundedImageEntity image;
  final bool isFinished;
  final List<ComponentEntity>? components;

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        createdAt,
        description2,
        isFinished,
        image,
        components,
      ];
}
