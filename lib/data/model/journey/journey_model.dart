import 'package:equatable/equatable.dart';
import 'package:kalm/data/model/meditation/rounded_image_model.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class JourneyModel extends Equatable implements ModelFactory {
  const JourneyModel({
    this.journeys,
  });

  final List<Journey>? journeys;

  factory JourneyModel.fromJson(Map<String, dynamic> json) => JourneyModel(
        journeys: List<Journey>.from(
            json["journeys"].map((x) => Journey.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "journeys": List<dynamic>.from(journeys!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [journeys];
}

class Journey extends Equatable implements ModelFactory {
  const Journey({
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
  final RoundedImage image;

  factory Journey.fromJson(Map<String, dynamic> json) => Journey(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        finishedProgress: json["finishedProgress"],
        totalProgress: json["totalProgress"],
        urutan: json["urutan"] ?? "",
        name: json["name"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        description2: json["description2"],
        image: RoundedImage.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "urutan": urutan,
        "finishedProgress": finishedProgress,
        "totalProgress": totalProgress,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "description2": description2,
        "image": image.toJson(),
      };

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
