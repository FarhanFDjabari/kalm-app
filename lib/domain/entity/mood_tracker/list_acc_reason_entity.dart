import 'package:equatable/equatable.dart';

class ListAccReasonEntity extends Equatable {
  const ListAccReasonEntity({
    required this.factor,
    required this.total,
  });

  final String? factor;
  final int? total;

  @override
  List<Object?> get props => [factor, total];
}
