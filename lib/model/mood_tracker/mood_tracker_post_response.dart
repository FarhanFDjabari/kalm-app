class MoodTrackerPostResponse {
  MoodTrackerPostResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  MoodTrackerPostResponse.fromJson(dynamic json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['mesage'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(v);
      });
    }
  }

  bool? success;
  int? statusCode;
  String? message;
  List<dynamic>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['statusCode'] = statusCode;
    map['mesage'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
