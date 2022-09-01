import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/cubit/mood_tracker/mood_tracker_cubit.dart';
import 'package:kalm/presentation/views/mood_tracker/mood_factor_page.dart';
import 'package:kalm/presentation/widgets/kalm_button.dart';
import 'package:kalm/presentation/widgets/kalm_slider.dart';
import 'package:kalm/styles/kalm_theme.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/utilities/routes/route_name.dart';

class MoodSwitcher extends StatefulWidget {
  MoodSwitcher({
    Key? key,
    required this.todayFinished,
    required this.context,
  }) : super(key: key);
  final bool todayFinished;
  final BuildContext context;

  @override
  State<MoodSwitcher> createState() => _MoodSwitcherState();
}

class _MoodSwitcherState extends State<MoodSwitcher> {
  int moodValue = 0;

  getMoodImage(int value) {
    switch (value) {
      case 0:
        return 'assets/picture/picture-moodtracker_buruk.png';
      case 1:
        return 'assets/picture/picture-moodtracker_biasaaja.png';
      case 2:
        return 'assets/picture/picture-moodtracker_baik.png';
    }
  }

  getMoodValue(int value) {
    switch (value) {
      case 0:
        return 'Buruk';
      case 1:
        return 'Biasa';
      case 2:
        return 'Baik';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.height * 0.35,
          child: Image.asset(
            getMoodImage(moodValue).toString(),
            scale: 1.7,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 22),
          child: Text(
            getMoodValue(moodValue),
            textAlign: TextAlign.center,
            style: kalmOfflineTheme.textTheme.headline1!
                .apply(color: primaryText, fontSizeFactor: 1.1),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Buruk'),
                  Text('Baik'),
                ],
              ),
              KalmSlider(
                onChanged: (value) {
                  setState(() {
                    moodValue = value.toInt();
                  });
                },
                trackHeight: 8,
                inactiveColor: tertiaryColor,
                value: moodValue.toDouble(),
                max: 2,
                min: 0,
              ),
              SizedBox(height: 32),
              if (widget.todayFinished)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: KalmButton(
                    width: double.infinity,
                    height: 56,
                    child: Text(
                      'Lihat grafik',
                      style: kalmOfflineTheme.textTheme.button!
                          .apply(color: tertiaryColor, fontSizeFactor: 1.2),
                    ),
                    primaryColor: primaryColor,
                    borderRadius: 10,
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.MOODGRAPH);
                    },
                  ),
                ),
              if (!widget.todayFinished)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: KalmButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(
                              RouteName.MOODCAMERA,
                            )
                                .then((value) {
                              widget.context
                                  .read<MoodTrackerCubit>()
                                  .fetchMoodTrackerHome(
                                      GetStorage().read('user_id'));
                            });
                          },
                          primaryColor: tertiaryColor,
                          height: MediaQuery.of(context).size.height * 0.085,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.scan,
                                color: primaryColor,
                                size: 28,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Kenali Perasaanmu',
                                style: kalmOfflineTheme.textTheme.button!.apply(
                                    color: primaryColor, fontSizeFactor: 0.95),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      KalmButton(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.085,
                        primaryColor: primaryColor,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: tertiaryColor,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (context) => MoodFactorPage(
                              moodPoint: moodValue.toDouble(),
                            ),
                          ))
                              .then((value) {
                            context
                                .read<MoodTrackerCubit>()
                                .fetchMoodTrackerHome(
                                    GetStorage().read('user_id'));
                          });
                        },
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
