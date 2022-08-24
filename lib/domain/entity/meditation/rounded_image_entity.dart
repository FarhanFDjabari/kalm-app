import 'package:hive/hive.dart';
import 'package:kalm/data/sources/local/hive_types.dart';

part 'rounded_image_entity.g.dart';

@HiveType(typeId: HiveTypes.ROUNDEDIMAGE)
class RoundedImageEntity extends HiveObject {
  RoundedImageEntity({
    this.url,
    this.thumbnail,
    this.preview,
  });

  @HiveField(0)
  final String? url;
  @HiveField(1)
  final String? thumbnail;
  @HiveField(2)
  final String? preview;
}
