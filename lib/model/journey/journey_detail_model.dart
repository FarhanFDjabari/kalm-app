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
    this.urutan,
    this.name,
    required this.createdAt,
    required this.description2,
    required this.image,
    this.components,
  });

  int id;
  String title;
  String author;
  String? urutan;
  String? name;
  DateTime createdAt;
  String description2;
  RoundedImage image;
  List<Component>? components;

  factory DetailJourney.fromJson(Map<String, dynamic> json) => DetailJourney(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        urutan: json["urutan"] != null ? json["urutan"] : '',
        name: json["name"] != null ? json["name"] : '',
        createdAt: DateTime.parse(json["created_at"]),
        description2: json["description2"],
        image: RoundedImage.fromJson(json["image"]),
        components: List<Component>.from(
            json["components"].map((x) => Component.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "urutan": urutan,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "description2": description2,
        "image": image.toJson(),
        "components": List<Component>.from(components!.map((x) => x.toJson())),
      };
}

class Component {
  Component({
    required this.id,
    required this.modelType,
    this.inModelId,
    this.urutan,
    required this.createdAt,
    required this.journeyId,
  });

  int id;
  String modelType;
  String? inModelId;
  String? urutan;
  DateTime createdAt;
  String journeyId;

  factory Component.fromJson(Map<String, dynamic> json) => Component(
        id: json["id"],
        modelType: json["model_type"],
        inModelId: json["in_model_id"],
        urutan: json["urutan"],
        createdAt: DateTime.parse(json["created_at"]),
        journeyId: json["journey_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "model_type": modelType,
        "in_model_id": inModelId,
        "urutan": urutan,
        "created_at": createdAt.toIso8601String(),
        "journey_id": journeyId,
      };
}
