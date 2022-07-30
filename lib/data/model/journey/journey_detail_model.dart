import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/meditation/rounded_image_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class JourneyDetailModel extends Equatable implements ModelFactory {
  const JourneyDetailModel({
    required this.journey,
  });

  final DetailJourney journey;

  factory JourneyDetailModel.fromJson(Map<String, dynamic> json) =>
      JourneyDetailModel(
        journey: DetailJourney.fromJson(json["journey"]),
      );

  Map<String, dynamic> toJson() => {
        "journey": journey.toJson(),
      };

  @override
  List<Object?> get props => [journey];
}

class DetailJourney extends Equatable implements ModelFactory {
  const DetailJourney({
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
  final RoundedImage image;
  final bool isFinished;
  final List<Component>? components;

  factory DetailJourney.fromJson(Map<String, dynamic> json) => DetailJourney(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        isFinished: json["is_finished"],
        createdAt: DateTime.parse(json["created_at"]),
        description2: json["description2"],
        image: RoundedImage.fromJson(json["image"]),
        components: json["components"] != null
            ? List<Component>.from(
                json["components"].map((x) => Component.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "created_at": createdAt.toIso8601String(),
        "description2": description2,
        "is_finished": isFinished,
        "image": image.toJson(),
        "components": List<Component>.from(components!.map((x) => x.toJson())),
      };

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

class Component extends Equatable implements ModelFactory {
  const Component({
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

  factory Component.fromJson(Map<String, dynamic> json) => Component(
        id: json["id"],
        modelType: json["model_type"],
        urutan: json["urutan"],
        createdAt: DateTime.parse(json["created_at"]),
        journeyId: json["journey_id"],
        name: json["name"] != null ? json["name"] : "name",
        isFinished: json["is_finished"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "model_type": modelType,
        "urutan": urutan,
        "created_at": createdAt.toIso8601String(),
        "journey_id": journeyId,
        "name": name,
        "is_finished": isFinished,
      };

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
