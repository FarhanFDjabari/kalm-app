class PlaylistModel {
  PlaylistModel({
    required this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  bool success;
  int? statusCode;
  String? message;
  Data? data;

  factory PlaylistModel.fromJson(Map<String, dynamic> json) => PlaylistModel(
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
    this.playlists,
  });

  List<Playlist>? playlists;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        playlists: List<Playlist>.from(
            json["playlists"].map((x) => Playlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "playlists": List<dynamic>.from(playlists!.map((x) => x.toJson())),
      };
}

class Playlist {
  Playlist({
    this.id,
    this.name,
    this.description,
    this.quantity,
    this.topicId,
    this.roundedImage,
    this.squaredImage,
    this.topic,
    this.playlistMusicItems,
  });

  int? id;
  String? name;
  String? description;
  String? quantity;
  String? topicId;
  RoundedImage? roundedImage;
  RoundedImage? squaredImage;
  Topic? topic;
  List<PlaylistMusicItem>? playlistMusicItems;

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        id: json["id"],
        name: json["name"],
        description: json["description2"],
        quantity: json["quantity"],
        topicId: json["topic_id"],
        roundedImage: RoundedImage.fromJson(json["rounded_image"]),
        squaredImage: RoundedImage.fromJson(json["squared_image"]),
        topic: Topic.fromJson(json["topic"]),
        playlistMusicItems: json["playlist_music_items"] != null
            ? List<PlaylistMusicItem>.from(json["playlist_music_items"]
                .map((x) => PlaylistMusicItem.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description2": description,
        "quantity": quantity,
        "topic_id": topicId,
        "rounded_image": roundedImage!.toJson(),
        "squared_image": squaredImage!.toJson(),
        "topic": topic!.toJson(),
        "playlist_music_items":
            List<dynamic>.from(playlistMusicItems!.map((x) => x.toJson())),
      };
}

class RoundedImage {
  RoundedImage({
    this.url,
    this.thumbnail,
    this.preview,
  });

  String? url;
  String? thumbnail;
  String? preview;

  factory RoundedImage.fromJson(Map<String, dynamic> json) => RoundedImage(
        url: json["url"],
        thumbnail: json["thumbnail"],
        preview: json["preview"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "thumbnail": thumbnail,
        "preview": preview,
      };
}

class PlaylistMusicItem {
  PlaylistMusicItem({
    this.id,
    this.name,
    this.duration,
    this.playlistId,
    this.musicFile,
    this.musicUrl,
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

  factory PlaylistMusicItem.fromJson(Map<String, dynamic> json) =>
      PlaylistMusicItem(
        id: json["id"],
        name: json["name"],
        duration: json["duration"],
        musicUrl: json["music_url"],
        playlistId: json["playlist_id"],
        musicFile: MusicFile.fromJson(json["music_file"]),
        roundedImage: RoundedImage.fromJson(json["rounded_image"]),
        squaredImage: json["squared_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duration": duration,
        "playlist_id": playlistId,
        "music_url": musicUrl,
        "music_file": musicFile!.toJson(),
        "rounded_image": roundedImage!.toJson(),
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

class Topic {
  Topic({
    this.id,
    this.name,
    this.description,
  });

  int? id;
  String? name;
  String? description;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        name: json["name"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description == null ? null : description,
      };
}
