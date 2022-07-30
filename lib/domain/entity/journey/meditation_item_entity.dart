import 'package:equatable/equatable.dart';
import 'package:kalm/domain/entity/meditation/rounded_image_entity.dart';

class MeditationItemEntity extends Equatable {
  const MeditationItemEntity({
    required this.id,
    required this.name,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    required this.playlistId,
    required this.journeyComponentId,
    required this.journeyId,
    required this.musicUrl,
    required this.roundedImage,
  });

  final int id;
  final String name;
  final String duration;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String playlistId;
  final int journeyComponentId;
  final int journeyId;
  final String musicUrl;
  final RoundedImageEntity roundedImage;

  @override
  List<Object?> get props => [
        id,
        name,
        duration,
        createdAt,
        updatedAt,
        playlistId,
        journeyComponentId,
        journeyId,
        musicUrl,
        roundedImage,
      ];
}
