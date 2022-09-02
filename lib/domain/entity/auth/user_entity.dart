import 'package:hive/hive.dart';
import 'package:kalm/data/sources/local/hive_types.dart';

part 'user_entity.g.dart';

@HiveType(typeId: HiveTypes.USER)
class UserEntity extends HiveObject {
  UserEntity({
    this.id,
    this.uuid,
    this.name,
    this.email,
    this.username,
    this.jenisKelamin,
    this.photoProfileUrl,
  });

  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? uuid;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final String? email;
  @HiveField(4)
  final String? username;
  @HiveField(5)
  final String? jenisKelamin;
  @HiveField(6)
  final String? photoProfileUrl;
}
