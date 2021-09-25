import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/views/curhat/curhat_home.dart';
import 'package:kalm/views/journey/journey_page.dart';
import 'package:kalm/views/meditation/meditation_audio_list.dart';
import 'package:kalm/views/mood_tracker/mood_tracker_page.dart';
import 'package:kalm/views/onboarding/onboarding_page.dart';
import 'package:kalm/views/splash.dart';
import 'package:kalm/views/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KALM',
      theme: kalmOfflineTheme,
      routes: {
        '/': (context) => View(),
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
