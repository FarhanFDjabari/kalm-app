import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class CurhatLike extends Equatable implements ModelFactory {
  const CurhatLike({
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

  factory CurhatLike.fromJson(Map<String, dynamic> json) => CurhatLike(
        userId: json["user_id"],
        id: json["id"],
        curhatanId: json["curhatan_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "id": id,
        "curhatan_id": curhatanId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        userId,
        id,
        curhatanId,
        createdAt,
        updatedAt,
      ];
}
