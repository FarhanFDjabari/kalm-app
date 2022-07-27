import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/cubit/auth/auth_cubit.dart';
import 'package:kalm/presentation/cubit/mood_tracker/mood_tracker_cubit.dart';
import 'package:kalm/presentation/views/mood_tracker/mood_camera.dart';
import 'package:kalm/presentation/views/mood_tracker/mood_factor_page.dart';
import 'package:kalm/presentation/views/mood_tracker/mood_graph_page.dart';
import 'package:kalm/presentation/widgets/kalm_button.dart';
import 'package:kalm/presentation/widgets/kalm_dialog.dart';
import 'package:kalm/presentation/widgets/kalm_slider.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/styles/kalm_theme.dart';

class MoodTrackerPage extends StatefulWidget {
  @override
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int moodValue = 0;
  bool todayFinished = false;

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
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoodTrackerCubit>(
          create: (_) => MoodTrackerCubit()
            ..fetchMoodTrackerHome(GetStorage().read('user_id')),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit()..getUserInfo(GetStorage().read('user_id')),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  KalmSnackbar(
                    message: state.errorMessage,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
          BlocListener<MoodTrackerCubit, MoodTrackerState>(
            listener: (context, state) {
              if (state is MoodTrackerError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  KalmSnackbar(
                    message: state.errorMessage,
                    duration: Duration(seconds: 2),
                  ),
                );
              } else if (state is MoodTrackerLoadSuccess) {
                if (state.moodTrackerData.isTodayFinished) {
                  showDialog(
                    context: context,
                    builder: (_) => KalmDialog(
                      title: 'Mood Tracker Hari Ini Sudah Terisi',
                      subtitle: 'Kamu sudah mengisi mood tracker hari ini',
                      successButtonTitle: 'Lihat Grafik',
                      onSuccess: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => MoodGraphPage(),
                          ),
                        );
                      },
                    ),
                  );
                  setState(() {
                    todayFinished = true;
                  });
                }
              }
            },
          ),
        ],
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/picture/picture-background_bottom_middle.png',
                ),
              ),
              Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    elevation: 0,
                    leading: Icon(
                      Iconsax.menu_1,
                      color: primaryText,
                    ),
                    title: Text(
                      'MOOD TRACKER',
                      style: kalmOfflineTheme.textTheme.headline1!.apply(
                        color: primaryText,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<MoodTrackerCubit, MoodTrackerState>(
                      builder: (builderContext, state) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            builderContext
                                .read<MoodTrackerCubit>()
                                .fetchMoodTrackerHome(
                                    GetStorage().read('user_id'));
                          },
                          color: primaryColor,
                          child: ListView(
                            children: [
                              Container(
                                child: BlocBuilder<AuthCubit, AuthState>(
                                  builder: (context, state) {
                                    return Text(
                                      state is AuthLoadSuccess
                                          ? 'Hai ${state.user.name}'
                                          : 'Hai ...',
                                      textAlign: TextAlign.center,
                                      style: kalmOfflineTheme
                                          .textTheme.bodyText1!
                                          .apply(
                                              color: primaryText,
                                              fontSizeFactor: 1.2),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                child: Text(
                                  'Bagaimana perasaanmu hari ini?',
                                  textAlign: TextAlign.center,
                                  style: kalmOfflineTheme.textTheme.headline1!
                                      .apply(
                                          color: primaryText,
                                          fontSizeFactor: 1.1),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
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
                                      .apply(
                                          color: primaryText,
                                          fontSizeFactor: 1.1),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                  ],
                                ),
                              ),
                              SizedBox(height: 32),
                              if (todayFinished)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: KalmButton(
                                    width: double.infinity,
                                    height: 56,
                                    child: Text(
                                      'Lihat grafik',
                                      style: kalmOfflineTheme.textTheme.button!
                                          .apply(
                                              color: tertiaryColor,
                                              fontSizeFactor: 1.2),
                                    ),
                                    primaryColor: primaryColor,
                                    borderRadius: 10,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => MoodGraphPage(),
                                          ));
                                    },
                                  ),
                                ),
                              if (!todayFinished)
                                BlocBuilder<MoodTrackerCubit, MoodTrackerState>(
                                  builder: (builderContext, state) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: KalmButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MoodCamera()),
                                                )
                                                    .then((value) {
                                                  builderContext
                                                      .read<MoodTrackerCubit>()
                                                      .fetchMoodTrackerHome(
                                                          GetStorage()
                                                              .read('user_id'));
                                                });
                                              },
                                              primaryColor: tertiaryColor,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.085,
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Iconsax.scan,
                                                    color: primaryColor,
                                                    size: 28,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Kenali Perasaanmu',
                                                    style: kalmOfflineTheme
                                                        .textTheme.button!
                                                        .apply(
                                                            color: primaryColor,
                                                            fontSizeFactor:
                                                                1.1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          KalmButton(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.085,
                                            primaryColor: primaryColor,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: tertiaryColor,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    MoodFactorPage(
                                                  moodPoint:
                                                      moodValue.toDouble(),
                                                ),
                                              ))
                                                  .then((value) {
                                                builderContext
                                                    .read<MoodTrackerCubit>()
                                                    .fetchMoodTrackerHome(
                                                        GetStorage()
                                                            .read('user_id'));
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
