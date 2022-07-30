import 'package:kalm/data/model/auth/login.dart';
import 'package:kalm/data/model/auth/user_info.dart';
import 'package:kalm/data/model/auth/user_model.dart';
import 'package:kalm/data/model/curhat/comment_model.dart';
import 'package:kalm/data/model/curhat/create_curhat_model.dart';
import 'package:kalm/data/model/curhat/curhat_like_model.dart';
import 'package:kalm/data/model/curhat/curhat_model.dart';
import 'package:kalm/data/model/curhat/detail_comment_model.dart';
import 'package:kalm/data/model/curhat/detail_curhat_model.dart';
import 'package:kalm/data/model/journey/journal_quote_model.dart';
import 'package:kalm/data/model/journey/journal_task_model.dart';
import 'package:kalm/data/model/journey/journey_detail_model.dart';
import 'package:kalm/data/model/journey/journey_model.dart';
import 'package:kalm/data/model/journey/meditation_task_model.dart';
import 'package:kalm/data/model/journey/question_model.dart';
import 'package:kalm/data/model/meditation/detail_playlist_model.dart';
import 'package:kalm/data/model/meditation/music_file_model.dart';
import 'package:kalm/data/model/meditation/music_model.dart';
import 'package:kalm/data/model/meditation/music_topic_model.dart';
import 'package:kalm/data/model/meditation/playlist_model.dart';
import 'package:kalm/data/model/meditation/playlist_music_item_model.dart';
import 'package:kalm/data/model/meditation/rounded_image_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_reason_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_daily_insight_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_home_model.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_post_response.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_weekly_insight_model.dart';
import 'package:kalm/data/model/mood_tracker/recomended_playlist_model.dart';

abstract class ModelFactory {
  factory ModelFactory.fromJson(Type type, Map<String, dynamic> json) {
    var strType = type.toString().replaceAll("?", "");
    // auth service
    if (strType == (Login).toString()) {
      return Login.fromJson(json);
    } else if (strType == (UserInfo).toString()) {
      return UserInfo.fromJson(json);
    } else if (strType == (User).toString()) {
      return User.fromJson(json);
    }
    // curhat service
    else if (strType == (CommentModel).toString()) {
      return CommentModel.fromJson(json);
    } else if (strType == (Comment).toString()) {
      return Comment.fromJson(json);
    } else if (strType == (CreateCurhatanModel).toString()) {
      return CreateCurhatanModel.fromJson(json);
    } else if (strType == (CreateCurhatan).toString()) {
      return CreateCurhatan.fromJson(json);
    } else if (strType == (CurhatModel).toString()) {
      return CurhatModel.fromJson(json);
    } else if (strType == (Curhatan).toString()) {
      return Curhatan.fromJson(json);
    } else if (strType == (DetailCurhatModel).toString()) {
      return DetailCurhatModel.fromJson(json);
    } else if (strType == (DetailCurhatan).toString()) {
      return DetailCurhatan.fromJson(json);
    } else if (strType == (DetailComment).toString()) {
      return DetailComment.fromJson(json);
    } else if (strType == (CurhatLike).toString()) {
      return CurhatLike.fromJson(json);
    }
    // journey service
    else if (strType == (JournalQuoteModel).toString()) {
      return JournalQuoteModel.fromJson(json);
    } else if (strType == (Quote).toString()) {
      return Quote.fromJson(json);
    } else if (strType == (JournalTaskModel).toString()) {
      return JournalTaskModel.fromJson(json);
    } else if (strType == (JournalItem).toString()) {
      return JournalItem.fromJson(json);
    } else if (strType == (Question).toString()) {
      return Question.fromJson(json);
    } else if (strType == (JourneyDetailModel).toString()) {
      return JourneyDetailModel.fromJson(json);
    } else if (strType == (DetailJourney).toString()) {
      return DetailJourney.fromJson(json);
    } else if (strType == (Component).toString()) {
      return Component.fromJson(json);
    } else if (strType == (JourneyModel).toString()) {
      return JourneyModel.fromJson(json);
    } else if (strType == (Journey).toString()) {
      return Journey.fromJson(json);
    } else if (strType == (MeditationTaskModel).toString()) {
      return MeditationTaskModel.fromJson(json);
    } else if (strType == (MeditationItem).toString()) {
      return MeditationItem.fromJson(json);
    }
    // meditation service
    else if (strType == (PlaylistModel).toString()) {
      return PlaylistModel.fromJson(json);
    } else if (strType == (Playlist).toString()) {
      return Playlist.fromJson(json);
    } else if (strType == (DetailPlaylistModel).toString()) {
      return DetailPlaylistModel.fromJson(json);
    } else if (strType == (RoundedImage).toString()) {
      return RoundedImage.fromJson(json);
    } else if (strType == (PlaylistMusicItem).toString()) {
      return PlaylistMusicItem.fromJson(json);
    } else if (strType == (MusicModel).toString()) {
      return MusicModel.fromJson(json);
    } else if (strType == (Music).toString()) {
      return Music.fromJson(json);
    } else if (strType == (Topic).toString()) {
      return Topic.fromJson(json);
    } else if (strType == (MusicFile).toString()) {
      return MusicFile.fromJson(json);
    }
    // mood tracker service
    else if (strType == (MoodTrackerDailyInsightModel).toString()) {
      return MoodTrackerDailyInsightModel.fromJson(json);
    } else if (strType == (MoodReason).toString()) {
      return MoodReason.fromJson(json);
    } else if (strType == (RecomendedPlaylist).toString()) {
      return RecomendedPlaylist.fromJson(json);
    } else if (strType == (MoodTrackerHomeModel).toString()) {
      return MoodTrackerHomeModel.fromJson(json);
    } else if (strType == (MoodTrackerPostResponse).toString()) {
      return MoodTrackerPostResponse.fromJson(json);
    } else if (strType == (MoodTrackerWeeklyInsightModel).toString()) {
      return MoodTrackerWeeklyInsightModel.fromJson(json);
    } else if (strType == (MoodTracker).toString()) {
      return MoodTracker.fromJson(json);
    } else if (strType == (ListAccReason).toString()) {
      return ListAccReason.fromJson(json);
    } else {
      throw UnimplementedError('`$type` factory unimplemented.');
    }
  }
}
