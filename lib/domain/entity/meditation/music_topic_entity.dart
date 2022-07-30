import 'package:equatable/equatable.dart';

class TopicEntity extends Equatable {
  const TopicEntity({
    this.id,
    this.name,
    this.description,
  });

  final int? id;
  final String? name;
  final String? description;

  @override
  List<Object?> get props => [id, name, description];
}
