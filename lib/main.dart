import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/cubit/auth/auth_cubit.dart';
import 'package:kalm/presentation/cubit/curhat/curhat_cubit.dart';
import 'package:kalm/presentation/cubit/journey/journey_cubit.dart';
import 'package:kalm/presentation/cubit/meditation/meditation_cubit.dart';
import 'package:kalm/presentation/cubit/mood_tracker/mood_tracker_cubit.dart';
import 'package:kalm/styles/kalm_theme.dart';
import 'package:kalm/utilities/routes/app_routes.dart';
import 'package:kalm/utilities/routes/route_name.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await di.init();
  await di.initHive();
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
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          title: 'KALM',
          theme: kalmOfflineTheme,
          debugShowCheckedModeBanner: false,
          routes: AppRoutes.pages,
          initialRoute: RouteName.SPLASH,
        ),
      ),
    );
  }
}
