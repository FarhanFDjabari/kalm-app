import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kalm/data/repository/auth_repository_impl.dart';
import 'package:kalm/data/repository/curhat_repository_impl.dart';
import 'package:kalm/data/repository/journey_repository_impl.dart';
import 'package:kalm/data/repository/meditation_repository_impl.dart';
import 'package:kalm/data/repository/mood_tracker_repository_impl.dart';
import 'package:kalm/data/sources/local/database_adapter.dart';
import 'package:kalm/data/sources/local/hive_constants.dart';
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/entity/meditation/playlist_music_item_entity.dart';
import 'package:kalm/domain/entity/meditation/rounded_image_entity.dart';
import 'package:kalm/domain/repository/auth_repository.dart';
import 'package:kalm/domain/repository/curhat_repository.dart';
import 'package:kalm/domain/repository/journey_repository.dart';
import 'package:kalm/domain/repository/meditation_repository.dart';
import 'package:kalm/domain/repository/mood_tracker_repository.dart';
import 'package:kalm/domain/usecases/auth/check_session.dart';
import 'package:kalm/domain/usecases/auth/create_user.dart';
import 'package:kalm/domain/usecases/auth/get_current_user.dart';
import 'package:kalm/domain/usecases/auth/get_user.dart';
import 'package:kalm/domain/usecases/auth/logout.dart';
import 'package:kalm/domain/usecases/auth/save_current_user.dart';
import 'package:kalm/domain/usecases/auth/sign_in.dart';
import 'package:kalm/domain/usecases/auth/update_profile.dart';
import 'package:kalm/domain/usecases/curhat/create_comment.dart';
import 'package:kalm/domain/usecases/curhat/create_curhat.dart';
import 'package:kalm/domain/usecases/curhat/get_all_curhat.dart';
import 'package:kalm/domain/usecases/curhat/get_all_curhat_by_category.dart';
import 'package:kalm/domain/usecases/curhat/get_curhat_detail.dart';
import 'package:kalm/domain/usecases/journey/get_all_journey.dart';
import 'package:kalm/domain/usecases/journey/get_journal_task.dart';
import 'package:kalm/domain/usecases/journey/get_journey_detail.dart';
import 'package:kalm/domain/usecases/journey/get_meditation_task.dart';
import 'package:kalm/domain/usecases/journey/get_quote.dart';
import 'package:kalm/domain/usecases/journey/post_journal_task.dart';
import 'package:kalm/domain/usecases/journey/post_meditation_task.dart';
import 'package:kalm/domain/usecases/meditation/get_all_playlist.dart';
import 'package:kalm/domain/usecases/meditation/get_all_playlist_by_category.dart';
import 'package:kalm/domain/usecases/meditation/get_playlist_detail.dart';
import 'package:kalm/domain/usecases/mood_tracker/get_daily_mood_insight.dart';
import 'package:kalm/domain/usecases/mood_tracker/get_mood_recognition.dart';
import 'package:kalm/domain/usecases/mood_tracker/get_mood_tracker_home_data.dart';
import 'package:kalm/domain/usecases/mood_tracker/get_weekly_mood_insight.dart';
import 'package:kalm/domain/usecases/mood_tracker/post_mood.dart';
import 'package:kalm/domain/usecases/mood_tracker/post_mood_image.dart';
import 'package:kalm/presentation/cubit/auth/auth_cubit.dart';
import 'package:kalm/presentation/cubit/curhat/curhat_cubit.dart';
import 'package:kalm/presentation/cubit/journey/journey_cubit.dart';
import 'package:kalm/presentation/cubit/meditation/meditation_cubit.dart';
import 'package:kalm/presentation/cubit/mood_tracker/mood_tracker_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // init supabase
  await Supabase.initialize(
    url: ConfigEnvironments.getEnvironments(),
    anonKey: ConfigEnvironments.getPublicKey(),
  );

  // cubit
  locator.registerFactory(
    () => AuthCubit(
      createUser: locator(),
      getUser: locator(),
      signOut: locator(),
      signIn: locator(),
      getCurrentUserUsecase: locator(),
      saveCurrentUserUsecase: locator(),
      updateProfile: locator(),
    ),
  );
  locator.registerFactory(
    () => CurhatCubit(
      createComment: locator(),
      createCurhat: locator(),
      getAllCurhat: locator(),
      getAllCurhatByCategory: locator(),
      getCurhatDetailUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => JourneyCubit(
      getAllJourney: locator(),
      getJournalTask: locator(),
      getJourneyDetailUsecase: locator(),
      getMeditationTaskUsecase: locator(),
      getQuote: locator(),
      postJournalTaskUsecase: locator(),
      postMeditationTaskUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => MeditationCubit(
      getAllPlaylist: locator(),
      getAllPlaylistByCategory: locator(),
      getPlaylistDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => MoodTrackerCubit(
      getDailyMoodInsight: locator(),
      getMoodTrackerHomeData: locator(),
      getWeeklyMoodInsight: locator(),
      postMood: locator(),
      getMoodRecognition: locator(),
      postMoodImage: locator(),
    ),
  );
  // usecases
  locator.registerLazySingleton(() => CreateUser(repository: locator()));
  locator.registerLazySingleton(() => GetUser(repository: locator()));
  locator.registerLazySingleton(() => Logout(repository: locator()));
  locator.registerLazySingleton(() => SignIn(repository: locator()));
  locator.registerLazySingleton(() => SaveCurrentUser(repository: locator()));
  locator.registerLazySingleton(() => GetCurrentUser(repository: locator()));
  locator.registerLazySingleton(() => CheckSession(repository: locator()));
  locator.registerLazySingleton(() => UpdateProfile(repository: locator()));

  locator.registerLazySingleton(() => CreateComment(repository: locator()));
  locator.registerLazySingleton(() => CreateCurhat(repository: locator()));
  locator.registerLazySingleton(() => GetAllCurhat(repository: locator()));
  locator.registerLazySingleton(
      () => GetAllCurhatByCategory(repository: locator()));
  locator.registerLazySingleton(() => GetCurhatDetail(repository: locator()));

  locator.registerLazySingleton(() => GetAllJourney(repository: locator()));
  locator.registerLazySingleton(() => GetJournalTask(repository: locator()));
  locator.registerLazySingleton(() => GetJourneyDetail(repository: locator()));
  locator.registerLazySingleton(() => GetMeditationTask(repository: locator()));
  locator.registerLazySingleton(() => GetQuote(repository: locator()));
  locator.registerLazySingleton(() => PostJournalTask(repository: locator()));
  locator
      .registerLazySingleton(() => PostMeditationTask(repository: locator()));

  locator.registerLazySingleton(() => GetAllPlaylist(repository: locator()));
  locator.registerLazySingleton(
      () => GetAllPlaylistByCategory(repository: locator()));
  locator.registerLazySingleton(() => GetPlaylistDetail(repository: locator()));

  locator
      .registerLazySingleton(() => GetDailyMoodInsight(repository: locator()));
  locator.registerLazySingleton(
      () => GetMoodTrackerHomeData(repository: locator()));
  locator
      .registerLazySingleton(() => GetWeeklyMoodInsight(repository: locator()));
  locator.registerLazySingleton(() => PostMood(repository: locator()));
  locator
      .registerLazySingleton(() => GetMoodRecognition(repository: locator()));
  locator.registerLazySingleton(() => PostMoodImage(repository: locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );
  locator.registerLazySingleton<CurhatRepository>(
    () => CurhatRepositoryImpl(),
  );
  locator.registerLazySingleton<JourneyRepository>(
    () => JourneyRepositoryImpl(),
  );
  locator.registerLazySingleton<MeditationRepository>(
    () => MeditationRepositoryImpl(),
  );
  locator.registerLazySingleton<MoodTrackerRepository>(
    () => MoodTrackerRepositoryImpl(),
  );

  // data sources

  // helper

  // external

  _initSystemPreference();
}

Future<void> initHive() async {
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  DatabaseAdapter().registerAdapter();
  await Hive.openBox<UserEntity>(HiveConstants.USERS);
  await Hive.openBox<PlaylistMusicItemEntity>(HiveConstants.MUSICS);
  await Hive.openBox<RoundedImageEntity>(HiveConstants.ROUNDEDIMAGE);
}

void _initSystemPreference() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
