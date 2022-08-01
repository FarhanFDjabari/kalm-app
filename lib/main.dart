import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/cubit/auth/auth_cubit.dart';
import 'package:kalm/presentation/cubit/curhat/curhat_cubit.dart';
import 'package:kalm/presentation/cubit/journey/journey_cubit.dart';
import 'package:kalm/presentation/cubit/meditation/meditation_cubit.dart';
import 'package:kalm/presentation/cubit/mood_tracker/mood_tracker_cubit.dart';
import 'package:kalm/presentation/views/auth/auth_page.dart';
import 'package:kalm/presentation/views/curhat/curhat_home.dart';
import 'package:kalm/presentation/views/journey/journey_page.dart';
import 'package:kalm/presentation/views/meditation/meditation_audio_list.dart';
import 'package:kalm/presentation/views/mood_tracker/mood_tracker_page.dart';
import 'package:kalm/presentation/views/onboarding/onboarding_page.dart';
import 'package:kalm/presentation/views/splash.dart';
import 'package:kalm/presentation/views/view.dart';
import 'package:kalm/styles/kalm_theme.dart';
import 'package:kalm/utilities/routes/route_name.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  di.init();
  runApp(KalmApp());
}

class KalmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.locator<AuthCubit>(),
        ),
        BlocProvider<CurhatCubit>(
          create: (_) => di.locator<CurhatCubit>(),
        ),
        BlocProvider<JourneyCubit>(
          create: (_) => di.locator<JourneyCubit>(),
        ),
        BlocProvider<MeditationCubit>(
          create: (_) => di.locator<MeditationCubit>(),
        ),
        BlocProvider<MoodTrackerCubit>(
          create: (_) => di.locator<MoodTrackerCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'KALM',
        theme: kalmOfflineTheme,
        debugShowCheckedModeBanner: false,
        routes: {
          RouteName.HOME: (context) => View(),
          RouteName.MEDITATIONPLAYLIST: (context) => MeditationAudioList(),
          RouteName.MOODTRACKER: (context) => MoodTrackerPage(),
          RouteName.SPLASH: (context) => Splash(),
          RouteName.ONBOARDING: (context) => OnboardingPage(),
          RouteName.JOURNEY: (context) => JourneyPage(),
          RouteName.CURHAT: (context) => CurhatHome(),
          RouteName.AUTH: (context) => AuthPage(),
        },
        initialRoute: RouteName.SPLASH,
      ),
    );
  }
}
