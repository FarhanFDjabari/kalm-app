import 'package:equatable/equatable.dart';
import 'package:kalm/domain/entity/meditation/rounded_image_entity.dart';

class RecomendedPlaylistEntity extends Equatable {
  const RecomendedPlaylistEntity({
    required this.id,
    this.name,
    this.description,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.topicId,
    this.description2,
    this.roundedImage,
    this.squaredImage,
  });

  final int id;
  final String? name;
  final String? description;
  final String? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? topicId;
  final String? description2;
  final RoundedImageEntity? roundedImage;
  final RoundedImageEntity? squaredImage;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        quantity,
        createdAt,
        updatedAt,
        topicId,
        description2,
        roundedImage,
        squaredImage,
      ];
}
