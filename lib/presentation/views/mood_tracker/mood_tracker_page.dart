import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/cubit/auth/auth_cubit.dart';
import 'package:kalm/presentation/cubit/mood_tracker/mood_tracker_cubit.dart';
import 'package:kalm/presentation/views/mood_tracker/mood_graph_page.dart';
import 'package:kalm/presentation/widgets/kalm_dialog.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/presentation/widgets/mood_switcher.dart';
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

  bool todayFinished = false;

  @override
  void initState() {
    context
        .read<MoodTrackerCubit>()
        .fetchMoodTrackerHome(GetStorage().read('user_id') ?? 0);
    context.read<AuthCubit>().getCurrentUser();
    super.initState();
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
            } else if (state is MoodTrackerLoadSuccess) {
              if (state.moodTrackerData.isTodayFinished) {
                // showDialog(
                //   context: context,
                //   builder: (_) => KalmDialog(
                //     title: 'Mood Tracker Hari Ini Sudah Terisi',
                //     subtitle: 'Kamu sudah mengisi mood tracker hari ini',
                //     successButtonTitle: 'Lihat Grafik',
                //     onSuccess: () {
                //       Navigator.pop(context);
                //       Navigator.of(context).push(
                //         MaterialPageRoute(
                //           builder: (_) => MoodGraphPage(),
                //         ),
                //       );
                //     },
                //   ),
                // );
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
                  leading: IconButton(
                    icon: Icon(Iconsax.menu_1),
                    color: primaryText,
                    onPressed: () => Scaffold.of(context).openDrawer(),
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
                                    style: kalmOfflineTheme.textTheme.bodyText1!
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
                            MoodSwitcher(
                                context: builderContext,
                                todayFinished: todayFinished),
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
    );
  }
}
