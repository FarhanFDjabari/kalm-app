import 'package:equatable/equatable.dart';

class MusicFileEntity extends Equatable {
  const MusicFileEntity({
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
