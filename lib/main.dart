import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/views/curhat/curhat_home.dart';
import 'package:kalm/views/journey/journey_page.dart';
import 'package:kalm/views/meditation/meditation_audio_list.dart';
import 'package:kalm/views/mood_tracker/mood_tracker_page.dart';
import 'package:kalm/views/onboarding/onboarding_page.dart';
import 'package:kalm/views/splash.dart';
import 'package:kalm/views/view.dart';
import 'package:kalm/widgets/custom_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
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
