import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/cubit/auth/auth_cubit.dart';
import 'package:kalm/cubit/mood_tracker/mood_tracker_cubit.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_meditation_tile.dart';
import 'package:kalm/widgets/kalm_mood_widget.dart';
import 'package:kalm/widgets/kalm_snackbar.dart';
import 'package:kalm/widgets/kalm_text_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final List<Map<String, String>> moodData = [
    {
      'imagePath': 'assets/picture/picture-mood_buruk.png',
      'label': 'Buruk',
    },
    {
      'imagePath': 'assets/picture/picture-mood_biasa.png',
      'label': 'Biasa',
    },
    {
      'imagePath': 'assets/picture/picture-mood_baik.png',
      'label': 'Baik',
    },
  ];

  String getGreeting(String name) {
    if (DateTime.now().hour > 18)
      return 'Selamat Malam, $name';
    else if (DateTime.now().hour > 14)
      return 'Selamat Sore, $name';
    else if (DateTime.now().hour > 10)
      return 'Selamat Siang, $name';
    else if (DateTime.now().hour > 4)
      return 'Selamat Pagi, $name';
    else
      return 'Selamat Pagi, $name';
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
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: Icon(
              Iconsax.menu_1,
              color: primaryText,
            ),
            title: Text(
              'HOME',
              style: kalmOfflineTheme.textTheme.headline1!.apply(
                color: primaryText,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.notification5,
                  color: primaryText,
                ),
              ),
            ],
          ),
          body: BlocBuilder<MoodTrackerCubit, MoodTrackerState>(
            builder: (builderContext, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  builderContext
                      .read<MoodTrackerCubit>()
                      .fetchMoodTrackerHome(GetStorage().read('user_id'));
                },
                color: primaryColor,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return Text(
                                state is AuthLoadSuccess
                                    ? getGreeting(state.user.name!)
                                    : getGreeting("User"),
                                style: kalmOfflineTheme.textTheme.bodyText1!
                                    .apply(
                                        color: primaryText,
                                        fontSizeFactor: 1.2),
                              );
                            },
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Bagaimana perasaanmu hari ini?',
                            style: kalmOfflineTheme.textTheme.headline1!
                                .apply(color: primaryText, fontSizeFactor: 1.2),
                          ),
                          SizedBox(height: 8),
                          KalmMoodWidget(moodData: moodData),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'Rekomendasi meditasi',
                                  style: kalmOfflineTheme.textTheme.bodyText1!
                                      .apply(
                                          color: primaryText,
                                          fontSizeFactor: 1.1),
                                ),
                              ),
                              KalmTextButton(
                                width: 120,
                                height: 20,
                                primaryColor: primaryColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Lihat Semua',
                                      style: kalmOfflineTheme
                                          .textTheme.bodyText1!
                                          .apply(
                                              color: primaryText,
                                              fontSizeFactor: 1),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: primaryText,
                                      size: 16,
                                    ),
                                  ],
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child:
                                BlocBuilder<MoodTrackerCubit, MoodTrackerState>(
                              builder: (builderContext, state) {
                                if (state is MoodTrackerLoadSuccess)
                                  return Container(
                                    child: ListView.builder(
                                        itemCount: 4,
                                        itemBuilder: (_, index) {
                                          List playlistList = state
                                              .moodTrackerData
                                              .reccomendedPlaylists!;
                                          return KalmMeditationTile(
                                            imagePath: playlistList[index]
                                                .squaredImage!
                                                .url!,
                                            title: playlistList[index].name!,
                                            description: playlistList[index]
                                                .description2!,
                                            series:
                                                playlistList[index].quantity!,
                                            playlistId: playlistList[index].id!,
                                          );
                                        }),
                                  );
                                else
                                  return Container(
                                    child: Center(
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
