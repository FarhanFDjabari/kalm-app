import 'package:flutter/widgets.dart';
import 'package:kalm/data/model/journey/journal_quote_model.dart';
import 'package:kalm/data/model/journey/journal_task_model.dart';
import 'package:kalm/data/model/journey/journey_detail_model.dart';
import 'package:kalm/data/model/journey/journey_model.dart';
import 'package:kalm/data/model/journey/meditation_task_model.dart';
import 'package:kalm/data/model/journey/question_model.dart';
import 'package:kalm/data/model/meditation/playlist_music_item_model.dart';
import 'package:kalm/data/model/meditation/rounded_image_model.dart';
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:supabase/supabase.dart';

class JourneyServiceSupa {
  final client = SupabaseClient(
      ConfigEnvironments.getEnvironments(), ConfigEnvironments.getPublicKey());

  Future<List<Journey>> fetchAllJourney({
    required int userId,
  }) async {
    try {
      final response = await client.from('journeys').select().execute();
      if (response.status! >= 200 && response.status! <= 299) {
        final journeysMapData = response.data as List<dynamic>;
        final journeysData =
            await Future.wait<Journey>(journeysMapData.map((journeys) async {
          final journeyComponents =
              await getJourneyComponents(journeyId: journeys['id']);
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
            await getJourneyComponents(journeyId: journeyId);

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

  Future<List<Component>> getJourneyComponents({required int journeyId}) async {
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
            .select('id, journey_component_id')
            .eq('journey_id', journeyId)
            .execute();

        final componentsHistory = componentHistoryList as List<dynamic>;

        final journeyComponents = await Future.wait<Component>(
          journeyComponentsMapData.map((journeyComponent) async {
            bool isFinished = false;
            componentsHistory.forEach((history) {
              if (journeyComponent['id'] == history['journey_component_id']) {
                isFinished = true;
              }
            });

            return Component(
              id: journeyComponent['id'] as int,
              modelType: journeyComponent['journey_type'] as String,
              createdAt: DateTime.tryParse(journeyComponent['created_at']) ??
                  DateTime.now(),
              journeyId: journeyComponent['journey_id'] as int,
              name: journeyComponent['name'] as String,
              urutan: journeyComponent['urutan'] as String,
              isFinished: isFinished,
            );
          }),
        );

        return journeyComponents;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
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
            journalId: journalTaskMapData.first['id']);

        final journalTaskData = JournalItem(
          id: journalTaskMapData.first['id'],
          name: journalTaskMapData.first['name'],
          createdAt: journalTaskMapData.first['created_at'],
          updatedAt: journalTaskMapData.first['created_at'],
          journeyComponentId: journalTaskMapData.first['id'],
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
          .eq('id', journalId)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final journalQuestionsMapData = response.data as List<dynamic>;

        final journalQuestionsData =
            journalQuestionsMapData.map((journalQuestion) {
          return Question(
            id: journalQuestion['id'],
            question: journalQuestion['question'],
            journalId: journalQuestion['journal_id'],
            createdAt: journalQuestion['created_at'],
            updatedAt: journalQuestion['created_at'],
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
      final response = await Future.wait<PostgrestResponse<dynamic>>(
          answers.map((answer) async {
        return await client.from('user_journal_answers').insert({
          'user_id': userId,
          'journal_question_id': componentId,
          'answers': answer['answer'],
          'journey_id': journeyId,
        }).execute();
      }));
      if (response.last.hasError) {
        throw ErrorDescription(response.last.error!.message);
      }
      final updateComponentHistory =
          await client.from('user_journey_component_history').insert({
        'user_id': userId,
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
            modelId: meditationTaskMapData.first['in_model_id']);

        final meditationTaskData = MeditationItem(
          id: meditationTaskMapData.first['id'],
          name: meditationTaskMapData.first['name'],
          duration: meditationItemData.duration ?? "0",
          createdAt: meditationTaskMapData.first['created_at'],
          updatedAt: meditationTaskMapData.first['created_at'],
          playlistId: meditationItemData.playlistId ?? "",
          journeyComponentId: meditationTaskMapData.first['id'],
          journeyId: meditationTaskMapData.first['journey_id'],
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
          id: playlistMusicItemMapData.first['id'],
          name: playlistMusicItemMapData.first['name'],
          duration: playlistMusicItemMapData.first['duration'],
          musicUrl: playlistMusicItemMapData.first['music_url'],
          playlistId: playlistMusicItemMapData.first['playlist_id'],
          roundedImage:
              RoundedImage(url: playlistMusicItemMapData.first['image']),
          squaredImage:
              RoundedImage(thumbnail: playlistMusicItemMapData.first['id']),
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
      final response = await client.from('user_journal_answers').insert({
        'user_id': userId,
        'journal_question_id': componentId,
        'journey_id': journeyId,
      }).execute();

      if (response.status! < 200 && response.status! > 299) {
        throw ErrorDescription(response.error!.message);
      }
      final updateComponentHistory =
          await client.from('user_journey_component_history').insert({
        'user_id': userId,
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
