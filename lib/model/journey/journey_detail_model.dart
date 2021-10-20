import 'package:kalm/model/meditation/playlist_model.dart';

class JourneyDetailModel {
  JourneyDetailModel({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  bool success;
  int statusCode;
  String message;
  Data? data;

  factory JourneyDetailModel.fromJson(Map<String, dynamic> json) =>
      JourneyDetailModel(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["mesage"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "mesage": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.journey,
  });

  DetailJourney journey;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        journey: DetailJourney.fromJson(json["journey"]),
      );

  Map<String, dynamic> toJson() => {
        "journey": journey.toJson(),
      };
}

class DetailJourney {
  DetailJourney({
    required this.id,
    required this.title,
    required this.author,
    required this.createdAt,
    required this.description2,
    required this.image,
    this.components,
    required this.isFinished,
  });

  int id;
  String title;
  String author;
  DateTime createdAt;
  String description2;
  RoundedImage image;
  bool isFinished;
  List<Component>? components;

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

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "title": title,
        "author": author,
        "created_at": createdAt.toIso8601String(),
        "description2": description2,
        "is_finished": isFinished,
        "image": image.toJson(),
        "components": List<Component>.from(components!.map((x) => x.toJson())),
      };
}

class Component {
  Component({
    required this.id,
    required this.modelType,
    this.urutan,
    required this.createdAt,
    required this.journeyId,
    this.name,
    required this.isFinished,
  });

  int id;
  String modelType;
  String? urutan;
  DateTime createdAt;
  int journeyId;
  String? name;
  bool isFinished;

  factory Component.fromJson(Map<String, dynamic> json) => Component(
        id: json["id"],
        modelType: json["model_type"],
        urutan: json["urutan"],
        createdAt: DateTime.parse(json["created_at"]),
        journeyId: json["journey_id"],
        name: json["name"] != null ? json["name"] : "name",
        isFinished: json["is_finished"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "model_type": modelType,
        "urutan": urutan,
        "created_at": createdAt.toIso8601String(),
        "journey_id": journeyId,
        "name": name,
        "is_finished": isFinished,
      };
}
