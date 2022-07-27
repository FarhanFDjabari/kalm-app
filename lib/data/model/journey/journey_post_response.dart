class JourneyPostResponse {
  JourneyPostResponse({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  bool success;
  int statusCode;
  String message;

  factory JourneyPostResponse.fromJson(Map<String, dynamic> json) =>
      JourneyPostResponse(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["mesage"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "mesage": message,
      };
}
