import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/cubit/journey/journey_cubit.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/views/journey/journey_chapter_page.dart';
import 'package:kalm/widgets/kalm_playlist_tile.dart';
import 'package:kalm/widgets/kalm_snackbar.dart';

class JourneyDetailPage extends StatelessWidget {
  final int journeyId;

  JourneyDetailPage({required this.journeyId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JourneyCubit>(
      create: (context) => JourneyCubit()
        ..getJourneyDetail(GetStorage().read('user_id'), journeyId),
      child: BlocListener<JourneyCubit, JourneyState>(
        listener: (context, state) {
          if (state is JourneyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              KalmSnackbar(
                duration: Duration(seconds: 2),
                message: state.errorMessage,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/picture/picture-background_top_middle.png',
                    scale: 1.5,
                  ),
                ),
                BlocBuilder<JourneyCubit, JourneyState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        AppBar(
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
                            style: kalmOfflineTheme.textTheme.headline1!
                                .apply(color: primaryText),
                          ),
                        ),
                        Container(
                          child: Image.asset(
                            'assets/picture/picture-journey_1.png',
                            scale: 2.2,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.075),
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Mengenali Diriku',
                            style: kalmOfflineTheme.textTheme.button!.copyWith(
                                color: primaryText,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                          child: Container(color: backgroundColor),
                        ),
                        Container(
                          color: backgroundColor,
                          width: double.infinity,
                          child: Text(
                            'Oleh Marina Mahendra, S.Psi, M.Psi',
                            style: kalmOfflineTheme.textTheme.subtitle1!
                                .apply(color: secondaryText),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                          child: Container(color: backgroundColor),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          color: backgroundColor,
                          child: Text(
                            'Kenali diri dan mulai mensyukuri segala hal. Lihat kelebihan dan kekurangan yang ada di dalam dirimu',
                            style: kalmOfflineTheme.textTheme.subtitle2!
                                .apply(color: primaryText),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            color: backgroundColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Progress Journey',
                                  style: kalmOfflineTheme.textTheme.bodyText1!
                                      .apply(color: primaryText),
                                ),
                                Text(
                                  '1/5',
                                  style: kalmOfflineTheme.textTheme.bodyText1!
                                      .apply(color: primaryText),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: backgroundColor,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: ListView.builder(
                                itemCount: 5,
                                padding: const EdgeInsets.only(top: 10),
                                itemBuilder: (_, index) => Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: KalmPlaylistTile(
                                    icon: Icons.flag,
                                    iconBackgroundColor: accentColor,
                                    iconColor: primaryColor,
                                    title: 'Mood Tracker',
                                    subtitle: 'Bagaimana perasaanmu hari ini?',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              JourneyChapterPage(),
                                        ),
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
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
