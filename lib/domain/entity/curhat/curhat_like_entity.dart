import 'package:equatable/equatable.dart';

class CurhatLikeEntity extends Equatable {
  const CurhatLikeEntity({
    this.userId,
    this.id,
    this.curhatanId,
    this.createdAt,
    this.updatedAt,
  });

  final String? userId;
  final int? id;
  final String? curhatanId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
        userId,
        id,
        curhatanId,
        createdAt,
        updatedAt,
      ];
}
