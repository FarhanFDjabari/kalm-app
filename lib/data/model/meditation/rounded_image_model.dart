import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class RoundedImage extends Equatable implements ModelFactory {
  const RoundedImage({
    this.url,
    this.thumbnail,
    this.preview,
  });

  final String? url;
  final String? thumbnail;
  final String? preview;

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

  @override
  List<Object?> get props => [url, thumbnail, preview];
}
