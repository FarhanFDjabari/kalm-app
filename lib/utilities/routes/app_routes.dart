import 'package:flutter/material.dart';
import 'package:kalm/presentation/views/auth/auth_page.dart';
import 'package:kalm/presentation/views/curhat/curhat_home.dart';
import 'package:kalm/presentation/views/journey/journey_page.dart';
import 'package:kalm/presentation/views/journey/mood_task/mood_camera_task.dart';
import 'package:kalm/presentation/views/meditation/meditation_audio_list.dart';
import 'package:kalm/presentation/views/mood_tracker/mood_graph_page.dart';
import 'package:kalm/presentation/views/mood_tracker/mood_tracker_page.dart';
import 'package:kalm/presentation/views/onboarding/onboarding_page.dart';
import 'package:kalm/presentation/views/splash.dart';
import 'package:kalm/presentation/views/view.dart';
import 'package:kalm/utilities/routes/route_name.dart';

class AppRoutes {
  static final Map<String, Widget Function(BuildContext)> pages = {
    RouteName.HOME: (context) => View(),
    RouteName.MEDITATIONPLAYLIST: (context) => MeditationAudioList(),
    RouteName.MOODTRACKER: (context) => MoodTrackerPage(),
    RouteName.SPLASH: (context) => Splash(),
    RouteName.ONBOARDING: (context) => OnboardingPage(),
    RouteName.JOURNEY: (context) => JourneyPage(),
    RouteName.CURHAT: (context) => CurhatHome(),
    RouteName.AUTH: (context) => AuthPage(),
    RouteName.MOODGRAPH: (context) => MoodGraphPage(),
    RouteName.MOODCAMERA: (context) => MoodCamera(),
  };
}
