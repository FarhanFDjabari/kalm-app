import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class MusicFile extends Equatable implements ModelFactory {
  const MusicFile({
    this.id,
    this.modelId,
    this.uuid,
    this.name,
    this.fileName,
    this.size,
    this.orderColumn,
  });

  final int? id;
  final String? modelId;
  final String? uuid;
  final String? name;
  final String? fileName;
  final String? size;
  final String? orderColumn;

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

  @override
  List<Object?> get props => [
        id,
        modelId,
        uuid,
        name,
        fileName,
        size,
        orderColumn,
      ];
}
