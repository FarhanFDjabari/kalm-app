import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';

class JournalQuoteModel extends Equatable implements ModelFactory {
  const JournalQuoteModel({
    required this.quote,
  });

  final Quote quote;

  factory JournalQuoteModel.fromJson(Map<String, dynamic> json) =>
      JournalQuoteModel(
        quote: Quote.fromJson(json["quote"]),
      );

  Map<String, dynamic> toJson() => {
        "quote": quote.toJson(),
      };

  @override
  List<Object?> get props => [quote];
}

class Quote extends Equatable implements ModelFactory {
  const Quote({
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

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        author: json["author"],
        createdAt: DateTime.parse(json["created_at"]),
        journeyId: json["journey_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "author": author,
        "created_at": createdAt.toIso8601String(),
        "journey_id": journeyId,
      };

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
