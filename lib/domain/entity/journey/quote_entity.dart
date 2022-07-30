import 'package:equatable/equatable.dart';

class QuoteEntity extends Equatable {
  const QuoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    required this.journeyId,
  });

  final int id;
  final String title;
  final String content;
  final String author;
  final DateTime createdAt;
  final String journeyId;

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        author,
        createdAt,
        journeyId,
      ];
}
