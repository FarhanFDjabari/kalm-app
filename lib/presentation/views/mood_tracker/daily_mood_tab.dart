import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:kalm/domain/entity/mood_tracker/recomended_playlist_entity.dart';
import 'package:kalm/presentation/cubit/mood_tracker/mood_tracker_cubit.dart';
import 'package:kalm/presentation/widgets/daily_mood_tile.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/styles/kalm_theme.dart';

class DailyMoodTab extends StatefulWidget {
  @override
  _DailyMoodTabState createState() => _DailyMoodTabState();
}

class _DailyMoodTabState extends State<DailyMoodTab> {
  getFormattedDate() {
    return DateFormat('d MMMM y').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<MoodTrackerCubit>()
        .fetchDailyMoodInsight(GetStorage().read('user_id'));
    return BlocListener<MoodTrackerCubit, MoodTrackerState>(
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
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: BlocBuilder<MoodTrackerCubit, MoodTrackerState>(
          builder: (context, state) {
            if (state is DailyInsightLoaded)
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            getFormattedDate(),
                            style: kalmOfflineTheme.textTheme.bodyText2!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor)
                                .apply(fontSizeFactor: 1.15),
                          ),
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {},
                      //   borderRadius: BorderRadius.circular(8),
                      //   splashColor: tertiaryColor,
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width * 0.1,
                      //     height: MediaQuery.of(context).size.width * 0.1,
                      //     decoration: BoxDecoration(
                      //       color: primaryColor,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Icon(
                      //       Icons.arrow_forward_ios_rounded,
                      //       color: tertiaryColor,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Moodmu Hari Ini',
                          style: kalmOfflineTheme.textTheme.button!
                              .apply(color: primaryText, fontSizeFactor: 1.1),
                        ),
                      ],
                    ),
                  ),
                  DailyMoodTile(
                      moodPoint: state.dailyInsightData.mood!,
                      reasons: state.dailyInsightData.reasons ?? []),
                  Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Rekomendasi Meditasi',
                      style: kalmOfflineTheme.textTheme.button!
                          .apply(color: primaryText, fontSizeFactor: 1.1),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 0.45,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            state.dailyInsightData.reccomendedPlaylists!.length,
                        itemBuilder: (_, index) {
                          RecomendedPlaylistEntity playlist = state
                              .dailyInsightData.reccomendedPlaylists![index];
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.width * 0.4,
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: tertiaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: playlist.roundedImage?.url ?? "",
                                  placeholder: (_, value) {
                                    return CircularProgressIndicator(
                                      color: primaryColor,
                                    );
                                  },
                                  imageBuilder: (_, __) => Image.network(
                                    playlist.squaredImage?.url ?? "",
                                    scale: 1.8,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  playlist.name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: kalmOfflineTheme.textTheme.bodyText1!
                                      .apply(
                                          color: primaryText,
                                          fontSizeFactor: 1.1),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '${playlist.quantity} Seri Audio',
                                  style: kalmOfflineTheme.textTheme.bodyText1!
                                      .apply(
                                    color: secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
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
    );
  }
}
