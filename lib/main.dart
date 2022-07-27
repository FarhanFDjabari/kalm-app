import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/views/curhat/curhat_home.dart';
import 'package:kalm/presentation/views/journey/journey_page.dart';
import 'package:kalm/presentation/views/meditation/meditation_audio_list.dart';
import 'package:kalm/presentation/views/mood_tracker/mood_tracker_page.dart';
import 'package:kalm/presentation/views/onboarding/onboarding_page.dart';
import 'package:kalm/presentation/views/splash.dart';
import 'package:kalm/presentation/views/view.dart';
import 'package:kalm/presentation/widgets/custom_drawer.dart';
import 'package:kalm/styles/kalm_theme.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KALM',
      theme: kalmOfflineTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Material(child: CustomDrawer(content: View())),
        '/meditation-playlist': (context) => MeditationAudioList(),
        '/mood-tracker': (context) => MoodTrackerPage(),
        '/splash': (context) => Splash(),
        '/onboarding': (context) => OnboardingPage(),
        '/journey': (context) => JourneyPage(),
        '/curhat': (context) => CurhatHome(),
      },
      initialRoute: '/splash',
    );
  }
}
