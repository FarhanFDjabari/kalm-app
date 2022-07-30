import 'package:equatable/equatable.dart';
import 'package:kalm/data/sources/remote/wrapper/model_factory.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_post_entity.dart';

class MoodTrackerPostResponse extends Equatable implements ModelFactory {
  MoodTrackerPostResponse({
    this.data,
  });

  MoodTrackerPostResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(v);
      });
    }
  }

  List<dynamic>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  MoodTrackerPostEntity toEntity() {
    return MoodTrackerPostEntity(data: data);
  }

  @override
  List<Object?> get props => [data];
}
