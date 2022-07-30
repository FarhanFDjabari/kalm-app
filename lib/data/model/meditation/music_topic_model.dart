import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/meditation/music_topic_entity.dart';

class Topic extends Equatable implements ModelFactory {
  const Topic({
    this.id,
    this.name,
    this.description,
  });

  final int? id;
  final String? name;
  final String? description;

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

  TopicEntity toEntity() {
    return TopicEntity(id: id, name: name, description: description);
  }

  @override
  List<Object?> get props => [id, name, description];
}
