import 'package:kalm/model/meditation/playlist_model.dart';

class JourneyModel {
  JourneyModel({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  bool success;
  int statusCode;
  String message;
  Data? data;

  factory JourneyModel.fromJson(Map<String, dynamic> json) => JourneyModel(
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
    this.journeys,
  });

  List<Journey>? journeys;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        journeys: List<Journey>.from(
            json["journeys"].map((x) => Journey.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "journeys": List<dynamic>.from(journeys!.map((x) => x.toJson())),
      };
}

class Journey {
  Journey({
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

  int id;
  int finishedProgress;
  int totalProgress;
  String title;
  String author;
  String? urutan;
  String? name;
  DateTime createdAt;
  DateTime updatedAt;
  String description2;
  RoundedImage image;

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
}
