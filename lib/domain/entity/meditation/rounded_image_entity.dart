import 'package:equatable/equatable.dart';

class RoundedImageEntity extends Equatable {
  const RoundedImageEntity({
    this.url,
    this.thumbnail,
    this.preview,
  });

  final String? url;
  final String? thumbnail;
  final String? preview;

  @override
  List<Object?> get props => [url, thumbnail, preview];
}
