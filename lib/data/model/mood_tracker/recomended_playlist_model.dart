import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/meditation/rounded_image_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class RecomendedPlaylist extends Equatable implements ModelFactory {
  const RecomendedPlaylist({
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
  final RoundedImage? roundedImage;
  final RoundedImage? squaredImage;

  factory RecomendedPlaylist.fromJson(Map<String, dynamic> json) =>
      RecomendedPlaylist(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        topicId: json["topic_id"],
        description2: json["description2"],
        roundedImage: RoundedImage.fromJson(json["rounded_image"]),
        squaredImage: RoundedImage.fromJson(json["squared_image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "quantity": quantity,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "topic_id": topicId,
        "description2": description2,
        "rounded_image": roundedImage!.toJson(),
        "squared_image": squaredImage!.toJson(),
      };

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
