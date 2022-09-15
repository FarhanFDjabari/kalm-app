import 'package:hive/hive.dart';
import 'package:kalm/data/sources/local/hive_types.dart';

part 'user_entity.g.dart';

@HiveType(typeId: HiveTypes.USER)
class UserEntity extends HiveObject {
  UserEntity({
    this.id,
    this.name,
    this.email,
    this.username,
    this.jenisKelamin,
    this.photoProfileUrl,
  });

  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? username;
  @HiveField(4)
  final String? jenisKelamin;
  @HiveField(6)
  final String? photoProfileUrl;
}
