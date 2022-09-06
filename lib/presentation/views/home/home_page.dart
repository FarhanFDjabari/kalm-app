import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/domain/entity/mood_tracker/recomended_playlist_entity.dart';
import 'package:kalm/presentation/cubit/auth/auth_cubit.dart';
import 'package:kalm/presentation/cubit/mood_tracker/mood_tracker_cubit.dart';
import 'package:kalm/presentation/widgets/kalm_meditation_tile.dart';
import 'package:kalm/presentation/widgets/kalm_mood_widget.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/styles/kalm_theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    context
        .read<MoodTrackerCubit>()
        .fetchMoodTrackerHome(GetStorage().read('user_id') ?? 0);
    context.read<AuthCubit>().getCurrentUser();
    super.initState();
  }

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

    return MultiBlocListener(
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
          leading: IconButton(
            icon: Icon(Iconsax.menu_1),
            color: primaryText,
            onPressed: () => Scaffold.of(context).openDrawer(),
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
                                  : getGreeting("-"),
                              style: kalmOfflineTheme.textTheme.bodyText1!
                                  .apply(
                                      color: primaryText, fontSizeFactor: 1.2),
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
                        SizedBox(height: 18),
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
                          ],
                        ),
                        const SizedBox(height: 18),
                        Expanded(
                          child:
                              BlocBuilder<MoodTrackerCubit, MoodTrackerState>(
                            builder: (builderContext, state) {
                              if (state is MoodTrackerLoadSuccess) {
                                if (state.moodTrackerData.reccomendedPlaylists!
                                    .isNotEmpty) {
                                  return Container(
                                    child: ListView.builder(
                                        itemCount: 4,
                                        itemBuilder: (_, index) {
                                          List<RecomendedPlaylistEntity>?
                                              playlistList = state
                                                  .moodTrackerData
                                                  .reccomendedPlaylists;
                                          return KalmMeditationTile(
                                            imagePath: playlistList?[index]
                                                    .squaredImage!
                                                    .url ??
                                                "-",
                                            title: playlistList?[index].name ??
                                                "-",
                                            description: playlistList?[index]
                                                    .description2 ??
                                                "-",
                                            series:
                                                playlistList?[index].quantity ??
                                                    "0",
                                            playlistId:
                                                playlistList?[index].id ?? 0,
                                          );
                                        }),
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      'Playlistmu masih kosong',
                                    ),
                                  );
                                }
                              } else
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
    );
  }
}
