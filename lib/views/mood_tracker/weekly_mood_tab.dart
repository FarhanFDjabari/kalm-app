import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/cubit/mood_tracker/mood_tracker_cubit.dart';
import 'package:kalm/model/mood_tracker/mood_tracker_weekly_response.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/dominasi_mood_tile.dart';
import 'package:kalm/widgets/kalm_mood_graph.dart';
import 'package:kalm/widgets/kalm_snackbar.dart';

class WeeklyMoodTab extends StatefulWidget {
  @override
  _WeeklyMoodTabState createState() => _WeeklyMoodTabState();
}

class _WeeklyMoodTabState extends State<WeeklyMoodTab> {
  String getTimeRange(DateTime date) {
    return '${date.day} - ${date.month} - ${date.year}';
  }

  IconData getMoodFactorIcon(String? moodFactor) {
    switch (moodFactor) {
      case 'Pekerjaan':
        return Iconsax.briefcase;
      case 'Tidur':
        return Iconsax.moon;
      case 'Hubungan':
        return Iconsax.lovely;
      case 'Keluarga':
        return Iconsax.home_2;
      case 'Teman':
        return Iconsax.profile_2user;
      case 'Pendidikan':
        return Iconsax.teacher;
      case 'Finansial':
        return Iconsax.empty_wallet;
      default:
        return Iconsax.bubble;
    }
  }

  int getMoodPoint(String sortedMood) {
    switch (sortedMood) {
      case 'Buruk':
        return 0;
      case 'Biasa':
        return 1;
      case 'Baik':
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoodTrackerCubit>(
      create: (context) => MoodTrackerCubit()
        ..fetchWeeklyMoodInsight(GetStorage().read('user_id')),
      child: BlocListener<MoodTrackerCubit, MoodTrackerState>(
        listener: (context, state) {
          if (state is MoodTrackerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              KalmSnackbar(
                message: state.errorMessage,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: BlocBuilder<MoodTrackerCubit, MoodTrackerState>(
              builder: (context, state) {
                if (state is WeeklyInsightLoaded)
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(8),
                            splashColor: tertiaryColor,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: tertiaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                '${getTimeRange(state.weeklyInsightData.moodTrackers[0].createdAt)} '
                                'sd. ${getTimeRange(state.weeklyInsightData.moodTrackers[6].createdAt)}',
                                style: kalmOfflineTheme.textTheme.bodyText2!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor)
                                    .apply(fontSizeFactor: 1.15),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(8),
                            splashColor: tertiaryColor,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: tertiaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Dominasi Emosimu',
                          style: kalmOfflineTheme.textTheme.button!
                              .apply(color: primaryText, fontSizeFactor: 1.1),
                        ),
                      ),
                      DominasiMoodTile(
                        moodPoint:
                            getMoodPoint(state.weeklyInsightData.sortedMood)
                                .toDouble(),
                        moodFactor:
                            state.weeklyInsightData.listAccReason![0].factor,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, bottom: 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Grafik Moodmu',
                          style: kalmOfflineTheme.textTheme.button!
                              .apply(color: primaryText, fontSizeFactor: 1.1),
                        ),
                      ),
                      KalmMoodGraph(
                        graphData: state.weeklyInsightData.moodTrackers,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Akumulasi Faktor Moodmu',
                          style: kalmOfflineTheme.textTheme.button!
                              .apply(color: primaryText, fontSizeFactor: 1.1),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          child: ListView.builder(
                              itemCount:
                                  state.weeklyInsightData.listAccReason!.length,
                              itemBuilder: (_, index) {
                                ListAccReason accReason = state
                                    .weeklyInsightData.listAccReason![index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ListTile(
                                    tileColor: tertiaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    leading: Icon(
                                      getMoodFactorIcon(accReason.factor),
                                      color: primaryColor,
                                      size: 28,
                                    ),
                                    title: Text(
                                      accReason.factor!,
                                      style: kalmOfflineTheme
                                          .textTheme.bodyText1!
                                          .apply(
                                              color: primaryText,
                                              fontSizeFactor: 1.2),
                                    ),
                                    trailing: Text(
                                      '${accReason.total}',
                                      style: kalmOfflineTheme
                                          .textTheme.bodyText1!
                                          .apply(
                                              color: secondaryText,
                                              fontSizeFactor: 1.2),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  );
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
      ),
    );
  }
}
