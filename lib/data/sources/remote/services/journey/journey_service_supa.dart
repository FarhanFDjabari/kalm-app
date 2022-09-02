import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kalm/data/model/journey/journal_quote_model.dart';
import 'package:kalm/data/model/journey/journal_task_model.dart';
import 'package:kalm/data/model/journey/journey_detail_model.dart';
import 'package:kalm/data/model/journey/journey_model.dart';
import 'package:kalm/data/model/journey/meditation_task_model.dart';
import 'package:kalm/data/model/journey/question_model.dart';
import 'package:kalm/data/model/meditation/playlist_music_item_model.dart';
import 'package:kalm/data/model/meditation/rounded_image_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class JourneyServiceSupa {
  final client = Supabase.instance.client;

  Future<List<Journey>> fetchAllJourney({
    required int userId,
  }) async {
    try {
      final response = await client.from('journeys').select().execute();
      if (response.status! >= 200 && response.status! <= 299) {
        final journeysMapData = response.data as List<dynamic>;
        final journeysData =
            await Future.wait<Journey>(journeysMapData.map((journeys) async {
          final journeyComponents = await getJourneyComponents(
              userId: userId, journeyId: journeys['id']);
          final finishedComponents = await getFinishedJourneyComponents(
              userId: userId, journeyId: journeys['id']);

          return Journey(
            id: journeys['id'] as int,
            createdAt:
                DateTime.tryParse(journeys['created_at']) ?? DateTime.now(),
            author: journeys['author'] as String,
            urutan: journeys['urutan'] as String?,
            name: journeys['name'] as String?,
            title: journeys['title'] as String,
            description2: journeys['description'] as String,
            finishedProgress: finishedComponents,
            image: RoundedImage(url: journeys['image'] as String),
            totalProgress: journeyComponents.length,
            updatedAt:
                DateTime.tryParse(journeys['created_at']) ?? DateTime.now(),
          );
        }));

        return journeysData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<int> getFinishedJourneyComponents(
      {required int userId, required int journeyId}) async {
    try {
      final response = await client
          .from('user_journey_component_history')
          .select('id')
          .eq('user_id', userId)
          .eq('journey_id', journeyId)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final finishedJourneyMapData = response.data as List<dynamic>;

        return finishedJourneyMapData.length;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<DetailJourney> getJourneyById({
    required int journeyId,
    required int userId,
  }) async {
    try {
      final response =
          await client.from('journeys').select().eq('id', journeyId).execute();
      if (response.status! >= 200 && response.status! <= 299) {
        final journeyComponents =
            await getJourneyComponents(userId: userId, journeyId: journeyId);

        final detailJourneyMapData = response.data as List<dynamic>;

        final finishedComponents = await getFinishedJourneyComponents(
            userId: userId, journeyId: detailJourneyMapData.first['id']);

        final detailJourneyData = DetailJourney(
          id: detailJourneyMapData.first['id'] as int,
          title: detailJourneyMapData.first['title'] as String,
          author: detailJourneyMapData.first['author'] as String,
          createdAt:
              DateTime.tryParse(detailJourneyMapData.first['created_at']) ??
                  DateTime.now(),
          description2: detailJourneyMapData.first['description'] as String,
          image:
              RoundedImage(url: detailJourneyMapData.first['image'] as String),
          isFinished: journeyComponents.length == finishedComponents,
          components: journeyComponents,
        );

        return detailJourneyData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<List<Component>> getJourneyComponents({
    required int journeyId,
    required int userId,
  }) async {
    try {
      final response = await client
          .from('journey_components')
          .select()
          .eq('journey_id', journeyId)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final journeyComponentsMapData = response.data as List<dynamic>;

        final componentHistoryList = await client
            .from('user_journey_component_history')
            .select('journey_component_id, user_id')
            .execute();

        if (componentHistoryList.hasError)
          throw ErrorDescription(componentHistoryList.error!.message);

        final componentsHistory = componentHistoryList as List<dynamic>;

        final journeyComponents = await Future.wait<Component>(
          journeyComponentsMapData.map((journeyComponent) async {
            bool isFinished = false;
            componentsHistory.forEach((history) {
              if (journeyComponent['id'] == history['journey_component_id'] &&
                  history['user_id'] == userId) {
                isFinished = true;
              }
            });

            switch (journeyComponent['journey_type']) {
              case 'music_items':
                final meditationItem = await getMeditationItem(
                  modelId: journeyComponent['in_model_id'],
                );
                journeyComponent['name'] = meditationItem.name;
                break;
              case 'journals':
                final journalTask = await getJournalTask(
                  userId: userId,
                  taskId: journeyComponent['in_model_id'],
                );
                journeyComponent['name'] = journalTask.name;
                break;
              case 'mood_trackers':
                journeyComponent['name'] = null;
                if (!isFinished) {
                  isFinished = await moodTrackerHandler(
                      userId: userId,
                      componentId: journeyComponent['id'] as int,
                      journeyId: journeyId);
                }
                break;
            }

            return Component(
              id: journeyComponent['id'] as int,
              modelType: journeyComponent['journey_type'] as String,
              createdAt: DateTime.tryParse(journeyComponent['created_at']) ??
                  DateTime.now(),
              journeyId: journeyComponent['journey_id'] as int,
              name: journeyComponent['name'] as String?,
              urutan: journeyComponent['urutan'] as String,
              isFinished: isFinished,
            );
          }),
        );

        journeyComponents
            .sort((a, b) => (a.urutan ?? "0").compareTo(b.urutan ?? "1"));

        return journeyComponents;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<bool> moodTrackerHandler({
    required int userId,
    required int componentId,
    required int journeyId,
  }) async {
    final todayDate = DateFormat.yMd().format(DateTime.now());
    final tomorrowDate =
        DateFormat.yMd().format(DateTime.now().add(Duration(days: 1)));

    final todayMoodTrackerData = await client
        .from('mood_tracker')
        .select('id')
        .eq('user_id', userId)
        .lte('created_at',
            tomorrowDate) // not sure if its created_at or updated_at. check it later
        .gte('created_at', todayDate)
        .execute();

    dynamic moodTrackerData;

    if (todayMoodTrackerData.hasError)
      throw ErrorDescription(todayMoodTrackerData.error!.message);

    final todayMoodTracker = todayMoodTrackerData.data as List<dynamic>;

    if (todayMoodTracker.isNotEmpty) {
      moodTrackerData = todayMoodTracker.first;

      await postMeditationTask(
        userId: userId,
        componentId: componentId,
        journeyId: journeyId,
      );
    }

    return moodTrackerData != null ? true : false;
  }

  Future<JournalItem> getJournalTask({
    required int userId,
    required int taskId,
  }) async {
    try {
      final response = await client
          .from('journey_components')
          .select()
          .eq('id', taskId)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final journalTaskMapData = response.data as List<dynamic>;

        final journalQuestionsData = await getJournalQuestions(
            journalId: journalTaskMapData.first['in_model_id']);

        final journalTaskData = JournalItem(
          id: journalTaskMapData.first['id'] as int,
          name: journalTaskMapData.first['name'] as String,
          createdAt:
              DateTime.tryParse(journalTaskMapData.first['created_at']) ??
                  DateTime.now(),
          updatedAt:
              DateTime.tryParse(journalTaskMapData.first['created_at']) ??
                  DateTime.now(),
          journeyComponentId: journalTaskMapData.first['in_model_id'] as int,
          journeyId: journalTaskMapData.first['journey_id'],
          questions: journalQuestionsData,
        );

        return journalTaskData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<List<Question>> getJournalQuestions({required int journalId}) async {
    try {
      final response = await client
          .from('journal_questions')
          .select()
          .eq('journal_id', journalId)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final journalQuestionsMapData = response.data as List<dynamic>;

        final journalQuestionsData =
            journalQuestionsMapData.map((journalQuestion) {
          return Question(
            id: journalQuestion['id'] as int,
            question: journalQuestion['question'].toString(),
            journalId: journalQuestion['journal_id'] as int,
            createdAt: DateTime.tryParse(journalQuestion['created_at']) ??
                DateTime.now(),
            updatedAt: DateTime.tryParse(journalQuestion['created_at']) ??
                DateTime.now(),
          );
        }).toList();

        return journalQuestionsData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<String> postJournalTask({
    required int userId,
    required int componentId,
    required int journeyId,
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      final currentDate = DateFormat.yMd().format(DateTime.now());
      final response = await Future.wait<PostgrestResponse<dynamic>>(
          answers.map((answer) async {
        return await client.from('user_journal_answers').insert({
          'user_id': userId,
          'created_at': currentDate,
          'journal_question_id': answer['id'],
          'answer': answer['answer'],
          'journey_id': journeyId,
        }).execute();
      }));

      if (response.last.hasError) {
        throw ErrorDescription(response.last.error!.message);
      }

      final updateComponentHistory =
          await client.from('user_journey_component_history').insert({
        'user_id': userId,
        'created_at': currentDate,
        'journey_component_id': componentId,
        'journey_id': journeyId,
      }).execute();

      if (updateComponentHistory.status! >= 200 &&
          updateComponentHistory.status! <= 299) {
        return "Journal Task Posted Successfully";
      }

      print(updateComponentHistory.error!.message);
      throw ErrorDescription(updateComponentHistory.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<Quote> getJourneyQuote({
    required int userId,
    required int journeyId,
  }) async {
    try {
      final response = await client
          .from('quotes')
          .select()
          .eq('journey_id', journeyId)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final quoteMapData = response.data as List<dynamic>;

        final quoteData = Quote(
          id: quoteMapData.first['id'] as int,
          title: quoteMapData.first['title'] as String,
          content: quoteMapData.first['content'] as String,
          author: quoteMapData.first['author'] as String,
          createdAt: DateTime.parse(quoteMapData.first['created_at']),
          journeyId: quoteMapData.first['journey_id'] as String,
        );

        return quoteData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<Quote> fetchRandomQuote() async {
    final response = await client.from('quotes').select().execute();

    if (response.hasError) throw ErrorDescription(response.error!.message);

    final quotesListMap = response.data as List<dynamic>;

    final randomIndex = Random().nextInt(quotesListMap.length);

    final randomQuoteData = quotesListMap[randomIndex];

    final quoteData = Quote(
      id: randomQuoteData['id'] as int,
      title: randomQuoteData['title'] as String,
      content: randomQuoteData['content'] as String,
      author: randomQuoteData['author'] as String,
      createdAt:
          DateTime.tryParse(randomQuoteData['created_at']) ?? DateTime.now(),
      journeyId: randomQuoteData['journey_id'] as String,
    );

    return quoteData;
  }

  Future<MeditationItem> getMeditationTask({
    required int userId,
    required int taskId,
  }) async {
    try {
      final response = await client
          .from('journey_components')
          .select()
          .eq('id', taskId)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final meditationTaskMapData = response.data as List<dynamic>;

        final meditationItemData = await getMeditationItem(
            modelId: meditationTaskMapData.first['in_model_id'] as int);

        final meditationTaskData = MeditationItem(
          id: meditationTaskMapData.first['id'] as int,
          name: meditationTaskMapData.first['name'].toString(),
          duration: meditationItemData.duration ?? "0",
          createdAt:
              DateTime.tryParse(meditationTaskMapData.first['created_at']) ??
                  DateTime.now(),
          updatedAt:
              DateTime.tryParse(meditationTaskMapData.first['created_at']) ??
                  DateTime.now(),
          playlistId: meditationItemData.playlistId ?? "",
          journeyComponentId: meditationTaskMapData.first['id'] as int,
          journeyId: meditationTaskMapData.first['journey_id'] as int,
          musicUrl: meditationItemData.musicUrl ?? "",
          roundedImage: meditationItemData.roundedImage ?? RoundedImage(),
        );

        return meditationTaskData;
      }

      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<PlaylistMusicItem> getMeditationItem({required int modelId}) async {
    try {
      final response =
          await client.from('musics').select().eq('id', modelId).execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final playlistMusicItemMapData = response.data as List<dynamic>;

        final playlistMusicItemData = PlaylistMusicItem(
          id: playlistMusicItemMapData.first['id'] as int?,
          name: playlistMusicItemMapData.first['name'] as String?,
          duration: playlistMusicItemMapData.first['duration'] as String?,
          musicUrl: playlistMusicItemMapData.first['music_url'] as String?,
          playlistId: playlistMusicItemMapData.first['playlist_id'] as String?,
          roundedImage: RoundedImage(
              url: playlistMusicItemMapData.first['image'] as String?),
          squaredImage: RoundedImage(
              url: playlistMusicItemMapData.first['id'] as String?),
        );

        return playlistMusicItemData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<String> postMeditationTask({
    required int userId,
    required int componentId,
    required int journeyId,
  }) async {
    try {
      final currentDate = DateFormat.yMd().format(DateTime.now());
      final response = await client.from('user_journal_answers').insert({
        'user_id': userId,
        'created_at': currentDate,
        'journal_question_id': componentId,
        'journey_id': journeyId,
      }).execute();

      if (response.status! < 200 && response.status! > 299) {
        throw ErrorDescription(response.error!.message);
      }
      final updateComponentHistory =
          await client.from('user_journey_component_history').insert({
        'user_id': userId,
        'created_at': currentDate,
        'journey_component_id': componentId,
        'journey_id': journeyId,
      }).execute();
      if (updateComponentHistory.status! >= 200 &&
          updateComponentHistory.status! <= 299) {
        return "Meditation Task Posted Successfully";
      }
      print(response.error!.message);
      throw ErrorDescription(updateComponentHistory.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }
}

final journeyServiceSupa = JourneyServiceSupa();
