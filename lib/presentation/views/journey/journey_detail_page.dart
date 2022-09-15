import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/data/model/journey/journey_detail_model.dart';
import 'package:kalm/domain/entity/journey/component_entity.dart';
import 'package:kalm/presentation/cubit/journey/journey_cubit.dart';
import 'package:kalm/presentation/views/journey/journey_chapter_page.dart';
import 'package:kalm/presentation/views/journey/journey_complete_page.dart';
import 'package:kalm/presentation/views/journey/meditation_task/task_meditation_player.dart';
import 'package:kalm/presentation/views/journey/mood_task/mood_tracker_task_page.dart';
import 'package:kalm/presentation/widgets/kalm_dialog.dart';
import 'package:kalm/presentation/widgets/kalm_playlist_tile.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/styles/kalm_theme.dart';

class JourneyDetailPage extends StatelessWidget {
  final int journeyId;

  JourneyDetailPage({required this.journeyId});

  String getTitleFromType(String type) {
    switch (type) {
      case "mood_trackers":
        return "Mood Tracker";
      case "journals":
        return "Psikoedukasi";
      case "music_items":
        return "Meditasi";
      default:
        return "Undefined";
    }
  }

  String getSubtitleFromType(String type, String name) {
    switch (type) {
      case "mood_trackers":
        return "Bagaimana perasaanmu hari ini?";
      case "journals":
        return "Tulis jurnal harian $name";
      case "music_items":
        return "Dengarkan “$name”";
      default:
        return "Undefined";
    }
  }

  taskRouteMap(BuildContext context, bool isFinished, String type, int taskId,
      int journeyId) {
    if (!isFinished) {
      if (type == 'mood_trackers') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MoodTrackerTaskPage(),
          ),
        ).then((value) => context
            .read<JourneyCubit>()
            .getJourneyDetail(GetStorage().read('user_id'), journeyId));
      } else if (type == 'journals') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => JourneyChapterPage(
              journeyId: journeyId,
              taskId: taskId,
            ),
          ),
        ).then((value) => context
            .read<JourneyCubit>()
            .getJourneyDetail(GetStorage().read('user_id'), journeyId));
      } else if (type == 'music_items') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TaskMeditationPlayer(
              journeyId: journeyId,
              taskId: taskId,
            ),
          ),
        ).then((value) => context
            .read<JourneyCubit>()
            .getJourneyDetail(GetStorage().read('user_id'), journeyId));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<JourneyCubit>()
        .getJourneyDetail(GetStorage().read('user_id'), journeyId);
    return BlocListener<JourneyCubit, JourneyState>(
      listener: (context, state) {
        if (state is JourneyError) {
          ScaffoldMessenger.of(context).showSnackBar(
            KalmSnackbar(
              duration: Duration(seconds: 2),
              message: state.errorMessage,
            ),
          );
        } else if (state is JourneyDetailLoaded) {
          if (state.detailJourney.isFinished) {
            showDialog(
                context: context,
                builder: (_) {
                  return KalmDialog(
                    title: 'Journey Selesai',
                    subtitle:
                        'Yeay! kamu telah selesai melakukan tugas di journey ini',
                    successButtonTitle: 'Lanjut',
                    height: MediaQuery.of(context).size.height * 0.275,
                    onSuccess: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => JourneyCompletePage(
                          journeyId: state.detailJourney.id,
                          imagePath: state.detailJourney.image.url!,
                        ),
                      ));
                    },
                  );
                });
          }
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: primaryText,
            ),
          ),
          title: Text(
            'JOURNEY',
            style:
                kalmOfflineTheme.textTheme.headline1!.apply(color: primaryText),
          ),
        ),
        body: BlocBuilder<JourneyCubit, JourneyState>(
          builder: (builderContext, state) {
            return Column(
              children: [
                if (state is JourneyDetailLoaded)
                  Column(
                    children: [
                      Container(
                        child: CachedNetworkImage(
                          imageUrl: state.detailJourney.image.url!,
                          imageBuilder: (_, __) {
                            return Image.network(
                              state.detailJourney.image.url!,
                              scale: 2.2,
                            );
                          },
                          placeholder: (_, __) {
                            return CircularProgressIndicator(
                              color: primaryColor,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: double.infinity,
                        child: Text(
                          '${state.detailJourney.title}',
                          style: kalmOfflineTheme.textTheme.button!.copyWith(
                              color: primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          '${state.detailJourney.author}',
                          style: kalmOfflineTheme.textTheme.subtitle1!
                              .apply(color: secondaryText, fontSizeFactor: 1.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Text(
                          '${state.detailJourney.description2}',
                          style: kalmOfflineTheme.textTheme.subtitle2!
                              .apply(color: primaryText, fontSizeFactor: 1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                if (state is JourneyLoading)
                  Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Aktivitas Journey',
                          style: kalmOfflineTheme.textTheme.bodyText1!
                              .apply(color: primaryText, fontSizeFactor: 1.1),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Material(
                    color: backgroundColor,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: BlocBuilder<JourneyCubit, JourneyState>(
                        builder: (context, state) {
                          if (state is JourneyDetailLoaded)
                            return ListView.builder(
                                itemCount:
                                    state.detailJourney.components?.length ?? 0,
                                padding: const EdgeInsets.only(top: 0),
                                itemBuilder: (_, index) {
                                  ComponentEntity task =
                                      state.detailJourney.components![index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: KalmPlaylistTile(
                                      icon: Icons.flag,
                                      iconBackgroundColor: task.isFinished
                                          ? primaryColor
                                          : accentColor,
                                      iconColor: task.isFinished
                                          ? tertiaryColor
                                          : primaryColor,
                                      title: getTitleFromType(task.modelType),
                                      subtitle: getSubtitleFromType(
                                          task.modelType, task.name ?? "-"),
                                      onTap: () {
                                        taskRouteMap(
                                          context,
                                          task.isFinished,
                                          task.modelType,
                                          task.id,
                                          task.journeyId,
                                        );
                                      },
                                      trailing: IconButton(
                                        onPressed: null,
                                        icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: primaryText,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          else
                            return Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            );
                        },
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
