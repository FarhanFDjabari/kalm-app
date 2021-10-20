class JourneyQuoteResponse {
  JourneyQuoteResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  bool success;
  int statusCode;
  String message;
  Data? data;

  factory JourneyQuoteResponse.fromJson(Map<String, dynamic> json) =>
      JourneyQuoteResponse(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["mesage"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "mesage": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.quote,
  });

  Quote quote;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        quote: Quote.fromJson(json["quote"]),
      );

  Map<String, dynamic> toJson() => {
        "quote": quote.toJson(),
      };
}

class Quote {
  Quote({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    required this.journeyId,
  });

  int id;
  String title;
  String content;
  String author;
  DateTime createdAt;
  String journeyId;

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
}
