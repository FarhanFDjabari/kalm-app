import 'package:flutter/widgets.dart';
import 'package:kalm/data/model/journey/journal_quote_model.dart';
import 'package:kalm/data/model/journey/journal_task_model.dart';
import 'package:kalm/data/model/journey/journey_detail_model.dart';
import 'package:kalm/data/model/journey/journey_model.dart';
import 'package:kalm/data/model/journey/meditation_task_model.dart';
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:supabase/supabase.dart';

class JourneyServiceSupa {
  final client = SupabaseClient(
      ConfigEnvironments.getEnvironments(), ConfigEnvironments.getPublicKey());

  Future<List<Journey>> fetchAllJourney({
    required int userId,
  }) async {
    final response =
        await client.from('journeys').select().execute();
    if (response.status! >= 200 && response.status! <= 299) {
      final journeysMapData = response.data as List<Map<String, dynamic>>;
      final journeysData = await Future.wait<Journey>(
        journeysMapData.map((journeys) async {
          []
        return Journey(
          id: journeys['id'],
          createdAt: DateTime.tryParse(journeys['created_at'])?? DateTime.now(),
          author: journeys['author'],
          urutan: journeys['urutan'],
          name: journeys['name'],
          title: journeys['title'],
          description2: journeys['description'],
          finishedProgress: ,
          image: journeys['image'],
          totalProgress: ,
          updatedAt: DateTime.tryParse(journeys['created_at'])?? DateTime.now(),
        );
      })
      );

      return journeysData;
    }
    throw ErrorDescription(response.error!.message);
  }

  Future<DetailJourney> getJourneyById({
    required int journeyId,
    required int userId,
  }) async {
    final response = await client.from('journeys').select().eq('id', journeyId).execute();
    if (response.status! >= 200 && response.status! <= 299) {
      final journeyComponents = await getJourneyComponents(journeyId: journeyId);

      final detailJourneyMapData = response.data as List<Map<String, dynamic>>;

      final detailJourneyData = DetailJourney(
          id: detailJourneyMapData.first['id'], 
          title: detailJourneyMapData.first['title'], 
          author: detailJourneyMapData.first['author'], 
          createdAt: DateTime.tryParse(detailJourneyMapData.first['created_at'])?? DateTime.now(), 
          description2: detailJourneyMapData.first['description'],
          image: detailJourneyMapData.first['image'], 
          isFinished: ,
          components: journeyComponents,
          );

      return detailJourneyData;
    }

    throw ErrorDescription(response.error!.message);
  }

  Future<List<Component>> getJourneyComponents({required int journeyId}) async {
    final response = await client.from('journey_components').select().eq('journey_id', journeyId).execute();

    if (response.status! >= 200 && response.status! <= 299) {
      final journeyComponentsMapData = response.data as List<Map<String, dynamic>>;

      final journeyComponents = await Future.wait<Component>(
        journeyComponentsMapData.map((journeyComponent) async {
          []
          return Component(
            id: journeyComponent['id'], 
            modelType: journeyComponent['journey_type'], 
            createdAt: DateTime.tryParse(journeyComponent['created_at'])?? DateTime.now(), 
            journeyId: journeyComponent['journey_id'], 
            name: journeyComponent['name'],
            urutan: journeyComponent['urutan'],
            isFinished: ,
            );
        }),
      );

      return journeyComponents;
    }    
    throw ErrorDescription(response.error!.message);
  }

  Future<JournalItem> getJournalTask({
    required int userId,
    required int taskId,
  }) async {
    final response = await client.from(table).execute();

    if (response.status! >= 200 && response.status! <= 299) {
      final journalTaskMapData;

      return JournalItem(
        id: id, 
        name: name, 
        createdAt: createdAt, 
        updatedAt: updatedAt, 
        journeyComponentId: journeyComponentId, 
        journeyId: journeyId, 
        questions: questions,
        );
    }
    throw ErrorDescription(response.error!.message);
  }

  Future<String> postJournalTask({
    required int userId,
    required int componentId,
    required int journeyId,
    required List<Map<String, dynamic>> answers,
  }) async {}

  Future<Quote> getJourneyQuote({
    required int userId,
    required int journeyId,
  }) async {}

  Future<MeditationItem> getMeditationTask({
    required int userId,
    required int taskId,
  }) async {}

  Future<String> postMeditationTask({
    required int userId,
    required int componentId,
    required int journeyId,
  }) async {}
}

final journeyServiceSupa = JourneyServiceSupa();
