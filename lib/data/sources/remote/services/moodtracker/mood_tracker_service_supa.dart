import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:kalm/data/model/meditation/rounded_image_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_reason_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_daily_insight_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_home_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_post_response.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_weekly_insight_model.dart';
import 'package:kalm/data/model/mood_tracker/recomended_playlist_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MoodTrackerServiceSupa {
  final client = Supabase.instance.client;

  Future<MoodTrackerHomeModel> fetchHomeData({required int userId}) async {
    try {
      final todayDate = DateFormat.yMd().format(DateTime.now());
      final tomorrowDate =
          DateFormat.yMd().format(DateTime.now().add(Duration(days: 1)));
      final response = await client
          .from('mood_tracker')
          .select()
          .eq('user_id', userId)
          .gte('created_at', todayDate)
          .lte('created_at', tomorrowDate)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final moodTrackerHomeMapData = response.data as List<dynamic>;

        if (moodTrackerHomeMapData.isNotEmpty) {
          final moodReasons = await getMoodReason(
              moodTrackerId: moodTrackerHomeMapData.first['id'] as int);

          final recomendedPlaylists = await getRecomendedPlaylist(
            reasons: moodReasons,
            moodPoint: moodTrackerHomeMapData.first['mood'] as int,
          );

          // bool isTodayFinished = checkIfTodayIsFinished(date: date);

          return MoodTrackerHomeModel(
            isTodayFinished: moodTrackerHomeMapData.isNotEmpty,
            mood: moodTrackerHomeMapData.first['mood'] as int?,
            reasons: moodReasons,
            reccomendedPlaylists: recomendedPlaylists,
          );
        } else {
          return MoodTrackerHomeModel(
            isTodayFinished: moodTrackerHomeMapData.isNotEmpty,
            mood: null,
            reasons: [],
            reccomendedPlaylists: [],
          );
        }
      }

      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  bool checkIfTodayIsFinished({required DateTime date}) {
    if (DateFormat.yMMMMd().format(date) ==
        DateFormat.yMMMMd().format(DateTime.now())) {
      return true;
    }
    return false;
  }

  Future<List<MoodReason>> getMoodReason({required int moodTrackerId}) async {
    try {
      final response = await client
          .from('mood_tracker_reasons')
          .select()
          .eq('mood_tracker_id', moodTrackerId)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final moodReasonsMapData = response.data as List<dynamic>;

        final moodReasonsData = moodReasonsMapData.map((moodReason) {
          return MoodReason(
            id: moodReason['id'] as int,
            moodTrackerId: moodReason['mood_tracker_id'].toString(),
            reason: moodReason['reason'].toString(),
          );
        }).toList();

        return moodReasonsData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<List<RecomendedPlaylist>> getRecomendedPlaylist(
      {required List<MoodReason> reasons, required int moodPoint}) async {
    try {
      // DEV TODO: make this recomended playlist logic work (current logic is pick random)

      final response =
          await client.from('playlists').select().range(0, 3).execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final playlistsMapData = response.data as List<dynamic>;

        final playlistsData = playlistsMapData.map((playlist) {
          return RecomendedPlaylist(
            id: playlist['id'] as int,
            name: playlist['name'] as String?,
            createdAt: DateTime.tryParse(playlist['created_at']),
            description2: playlist['description'] as String?,
            quantity: playlist['quantity'].toString(),
            topicId: playlist['topic_id'].toString(),
            roundedImage: RoundedImage(url: playlist['image'] as String?),
            squaredImage: RoundedImage(url: playlist['thumbnail'] as String?),
          );
        }).toList();

        return playlistsData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<MoodTrackerDailyInsightModel> fetchDailyMoodInsight({
    required int userId,
  }) async {
    try {
      final todayDate = DateFormat.yMd().format(DateTime.now());
      final tomorrowDate =
          DateFormat.yMd().format(DateTime.now().add(Duration(days: 1)));
      final response = await client
          .from('mood_tracker')
          .select()
          .eq('user_id', userId)
          .gte('created_at', todayDate)
          .lte('created_at', tomorrowDate)
          .limit(1)
          .single()
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final dailyMoodMapData = response.data;

        final moodReasons = await getMoodReason(
          moodTrackerId: dailyMoodMapData['id'],
        );

        final recommendedPlaylists = await getRecomendedPlaylist(
          reasons: moodReasons,
          moodPoint: dailyMoodMapData['mood'],
        );

        final dailyMoodData = MoodTrackerDailyInsightModel(
          isTodayFinished: dailyMoodMapData['mood'] != null ? true : false,
          mood: dailyMoodMapData['mood'] as int?,
          reasons: moodReasons,
          reccomendedPlaylists: recommendedPlaylists,
        );

        return dailyMoodData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<MoodTrackerWeeklyInsightModel> fetchWeeklyMoodInsight({
    required int userId,
  }) async {
    try {
      final todaysDate = DateTime.now();
      final dateBegin = DateFormat.yMd().format(DateTime(todaysDate.year,
          todaysDate.month, todaysDate.day - (todaysDate.weekday - 1)));
      final dateEnd = DateFormat.yMd().format(todaysDate
          .add(Duration(days: DateTime.daysPerWeek - todaysDate.weekday)));

      final response = await client
          .from('mood_tracker')
          .select()
          .eq('user_id', userId)
          .gte('created_at', dateBegin)
          .lte('created_at', dateEnd)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        var moodTrackersMapData = response.data as List<dynamic>;
        final accReasonsData = <MoodReason>[];
        final dateStart = DateTime(todaysDate.year, todaysDate.month,
            todaysDate.day - (todaysDate.weekday - 1));
        final dateStop = todaysDate
            .add(Duration(days: DateTime.daysPerWeek - todaysDate.weekday));

        final dateInThisWeek = [
          dateStart,
          dateStart.add(const Duration(days: 1)),
          dateStart.add(const Duration(days: 2)),
          dateStart.add(const Duration(days: 3)),
          dateStart.add(const Duration(days: 4)),
          dateStart.add(const Duration(days: 5)),
          dateStop,
        ];

        var moodTrackersData = await Future.wait<MoodTracker>(
            moodTrackersMapData.mapIndexed((index, moodTrackerMap) async {
          final moodReasons =
              await getMoodReason(moodTrackerId: moodTrackerMap['id']);
          return MoodTracker(
            index: index,
            createdAt: DateTime.tryParse(moodTrackerMap['created_at']) ??
                DateTime.now(),
            updatedAt: DateTime.tryParse(moodTrackerMap['created_at']) ??
                DateTime.now(),
            mood: moodTrackerMap['mood'] as int,
            reasons: moodReasons,
          );
        }));

        int index = 0;
        for (var i = 0; i < dateInThisWeek.length; i++) {
          var existedItem = moodTrackersData.firstWhereOrNull((moodTracker) {
            final isDateIsAfterOrNow =
                moodTracker.createdAt.isAfter(dateInThisWeek[i]) ||
                    moodTracker.createdAt.isAtSameMomentAs(dateInThisWeek[i]);
            final isDateIsBeforeOrNow = (i == dateInThisWeek.length - 1)
                ? true
                : moodTracker.createdAt.isBefore(dateInThisWeek[i + 1]) ||
                    moodTracker.createdAt
                        .isAtSameMomentAs(dateInThisWeek[i + 1]);
            return isDateIsAfterOrNow && isDateIsBeforeOrNow;
          });

          if (existedItem == null) {
            final newItem = MoodTracker(
              index: index,
              createdAt: dateInThisWeek[i],
              updatedAt: dateInThisWeek[i],
              mood: 0,
              reasons: [],
            );
            moodTrackersData.add(newItem);
            index++;
            continue;
          }
          existedItem.index = index;
          index++;
          accReasonsData.addAll(existedItem.reasons ?? []);
        }

        // sorted mood tracker
        moodTrackersData.sortBy((element) => element.createdAt);

        // sorted mood
        var sortedMood = <String, int>{"Buruk": 0, "Biasa": 0, "Baik": 0};
        var burukCount = 0;
        var biasaCount = 0;
        var baikCount = 0;
        moodTrackersData.forEach((element) {
          switch (element.mood) {
            case 0:
              burukCount++;
              sortedMood["Buruk"] = burukCount;
              break;
            case 1:
              biasaCount++;
              sortedMood["Biasa"] = biasaCount;
              break;
            case 2:
              baikCount++;
              sortedMood["Baik"] = baikCount;
              break;
          }
        });
        var finalSortedMood = "";

        sortedMood.entries.forEachIndexed((index, element) {
          if (index > 0) {
            if (element.value > sortedMood.entries.toList()[index - 1].value) {
              finalSortedMood = element.key;
            } else {
              if (sortedMood.entries.toList()[index - 1].value >
                  sortedMood.entries.toList().first.value) {
                finalSortedMood = sortedMood.entries.toList()[index - 1].key;
              } else {
                finalSortedMood = sortedMood.entries.toList().first.key;
              }
            }
          }
        });

        // sorted accumulated reason
        var listAccReasonData = <String, int>{
          'Tidur': 0,
          'Pekerjaan': 0,
          'Hubungan': 0,
          'Keluarga': 0,
          'Teman': 0,
          'Pendidikan': 0,
          'Finansial': 0,
          'Lainnya': 0,
        };
        accReasonsData.forEach((element) {
          listAccReasonData[element.reason!] =
              listAccReasonData[element.reason!]! + 1;
        });
        var accumulatedReason = <ListAccReason>[];
        listAccReasonData.forEach((key, value) {
          if (value > 0) {
            accumulatedReason.add(ListAccReason(factor: key, total: value));
          }
        });

        final weeklyMoodData = MoodTrackerWeeklyInsightModel(
          listAccReason: accumulatedReason,
          moodTrackers: moodTrackersData,
          sortedMood: finalSortedMood,
        );

        return weeklyMoodData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<MoodTrackerPostResponse> postMoodTracker({
    required int userId,
    required int mood,
    required List<String> reasons,
  }) async {
    try {
      final currentDate = DateFormat.yMd().format(DateTime.now());
      final response = await client.from('mood_tracker').insert({
        "mood": mood,
        'created_at': currentDate,
        "user_id": userId,
      }).execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final moodTrackerMapData = response.data as List<dynamic>;
        final moodTrackerReasonResponse =
            await Future.wait<PostgrestResponse<dynamic>>(
                reasons.map((reason) async {
          return await client.from('mood_tracker_reasons').insert({
            'mood_tracker_id': moodTrackerMapData.first['id'],
            'created_at': currentDate,
            'reason': reason
          }).execute();
        }));
        if (moodTrackerReasonResponse.last.hasError) {
          throw ErrorDescription(moodTrackerReasonResponse.last.error!.message);
        }
        return MoodTrackerPostResponse(data: moodTrackerMapData);
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<String> postMoodImage({
    required File image,
    required int userId,
  }) async {
    try {
      final fileName = image.uri.pathSegments.last;

      final storageList =
          await client.storage.from('images').list(path: 'mood_images/$userId');
      final filesToRemove = storageList.data
          ?.map((e) => 'mood_images/$userId/${e.name}')
          .toList();
      await client.storage.from('images').remove(filesToRemove ?? []);

      final response = await client.storage.from('images').upload(
            'mood_images/$userId/$fileName',
            image,
          );
      if (response.error == null) {
        final publicUrlData = client.storage
            .from('images')
            .getPublicUrl('mood_images/$userId/$fileName');

        if (publicUrlData.hasError)
          throw ErrorDescription(publicUrlData.error!.message);

        return publicUrlData.data ?? "";
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }
}

final moodTrackerServiceSupa = MoodTrackerServiceSupa();
