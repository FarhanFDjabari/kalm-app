import 'package:equatable/equatable.dart';
import 'package:kalm/domain/entity/meditation/music_topic_entity.dart';
import 'package:kalm/domain/entity/meditation/playlist_music_item_entity.dart';
import 'package:kalm/domain/entity/meditation/rounded_image_entity.dart';

class PlaylistEntity extends Equatable {
  const PlaylistEntity({
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

  final int? id;
  final String? name;
  final String? description;
  final String? quantity;
  final String? topicId;
  final RoundedImageEntity? roundedImage;
  final RoundedImageEntity? squaredImage;
  final TopicEntity? topic;
  final List<PlaylistMusicItemEntity>? playlistMusicItems;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        quantity,
        topicId,
        roundedImage,
        squaredImage,
        topic,
        playlistMusicItems,
      ];
}
