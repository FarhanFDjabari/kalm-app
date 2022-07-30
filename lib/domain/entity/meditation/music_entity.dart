import 'package:equatable/equatable.dart';
import 'package:kalm/domain/entity/meditation/music_file_entity.dart';
import 'package:kalm/domain/entity/meditation/rounded_image_entity.dart';

class MusicEntity extends Equatable {
  const MusicEntity({
    this.id,
    this.name,
    this.duration,
    this.playlistId,
    this.musicUrl,
    this.musicFile,
    this.roundedImage,
    this.squaredImage,
  });

  final int? id;
  final String? name;
  final String? duration;
  final String? playlistId;
  final String? musicUrl;
  final MusicFileEntity? musicFile;
  final RoundedImageEntity? roundedImage;
  final RoundedImageEntity? squaredImage;

  @override
  List<Object?> get props => [
        id,
        name,
        duration,
        playlistId,
        musicUrl,
        musicFile,
        roundedImage,
        squaredImage,
      ];
}
