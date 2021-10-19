import 'package:kalm/model/meditation/playlist_model.dart';

class MusicModel {
  MusicModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
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
    this.music,
  });

  List<Music>? music;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        music: List<Music>.from(json["music"].map((x) => Music.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "music": List<dynamic>.from(music!.map((x) => x.toJson())),
      };
}

class Music {
  Music({
    this.id,
    this.name,
    this.duration,
    this.playlistId,
    this.musicUrl,
    this.musicFile,
    this.roundedImage,
    this.squaredImage,
  });

  int? id;
  String? name;
  String? duration;
  String? playlistId;
  String? musicUrl;
  MusicFile? musicFile;
  RoundedImage? roundedImage;
  RoundedImage? squaredImage;

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        id: json["id"],
        name: json["name"],
        duration: json["duration"],
        playlistId: json["playlist_id"],
        musicUrl: json["music_url"],
        musicFile: MusicFile.fromJson(json["music_file"]),
        roundedImage: json["rounded_image"],
        squaredImage: json["squared_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duration": duration,
        "playlist_id": playlistId,
        "music_url": musicUrl,
        "music_file": musicFile!.toJson(),
        "rounded_image": roundedImage,
        "squared_image": squaredImage,
      };
}

class MusicFile {
  MusicFile({
    this.id,
    this.modelId,
    this.uuid,
    this.name,
    this.fileName,
    this.size,
    this.orderColumn,
  });

  int? id;
  String? modelId;
  String? uuid;
  String? name;
  String? fileName;
  String? size;
  String? orderColumn;

  factory MusicFile.fromJson(Map<String, dynamic> json) => MusicFile(
        id: json["id"],
        modelId: json["model_id"],
        uuid: json["uuid"],
        name: json["name"],
        fileName: json["file_name"],
        size: json["size"],
        orderColumn: json["order_column"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "model_id": modelId,
        "uuid": uuid,
        "name": name,
        "file_name": fileName,
        "size": size,
        "order_column": orderColumn,
      };
}
