import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/cubit/journey/journey_cubit.dart';
import 'package:kalm/presentation/widgets/kalm_dialog.dart';
import 'package:kalm/presentation/widgets/kalm_slider.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/presentation/widgets/meditation_meta_info.dart';
import 'package:kalm/styles/kalm_theme.dart';
import 'package:kalm/utilities/iconsax_icons.dart';

class TaskMeditationPlayer extends StatefulWidget {
  final int taskId;
  final int journeyId;

  TaskMeditationPlayer({required this.taskId, required this.journeyId});

  @override
  _TaskMeditationPlayerState createState() => _TaskMeditationPlayerState();
}

class _TaskMeditationPlayerState extends State<TaskMeditationPlayer> {
  AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState _playerState = PlayerState.paused;
  Duration _progress = Duration();
  Duration _audioDuration = Duration();
  int playIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<JourneyCubit>().getMeditationTask(
          GetStorage().read('user_id'),
          widget.taskId,
        );

    _audioPlayer.onPlayerStateChanged.listen((audioState) {
      if (audioState == PlayerState.stopped) {
        _playerState = audioState;
      } else {
        setState(() {
          _playerState = audioState;
        });
      }
    });

    _audioPlayer.onDurationChanged.listen((currentDuration) {
      setState(() {
        _audioDuration = currentDuration;
      });
    });

    _audioPlayer.onPositionChanged.listen((currentPosition) {
      setState(() {
        _progress = currentPosition;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _progress = Duration(seconds: 0);
        _audioPlayer.stop();
      });
      postMeditationTask();
    });
  }

  @override
  void dispose() {
    super.dispose();
    disposeAudio();
  }

  play(String url) async {
    await _audioPlayer.resume();
  }

  pause() async {
    await _audioPlayer.pause();
  }

  seekTo(int value) async {
    await _audioPlayer.seek(Duration(seconds: value));
  }

  disposeAudio() async {
    await _audioPlayer.release();
    await _audioPlayer.dispose();
  }

  String timeFormatter(String duration) {
    List<String> formatted = duration.split(':');
    return '${formatted[1]}:${formatted[2]}';
  }

  void postMeditationTask() async {
    context.read<JourneyCubit>().postMeditationTask(
        GetStorage().read('user_id'), widget.taskId, widget.journeyId);
    showDialog(
        context: context,
        builder: (_) {
          return KalmDialog(
            title: 'Selamat! kamu telah menyelesaikan aktivitas ini',
            subtitle:
                'Kamu dapat kembali untuk melakukan aktivitas selanjutnya atau tetap disini untuk mendengarkan meditasi',
            successButtonTitle: 'Oke',
            height: MediaQuery.of(context).size.height * 0.275,
            onSuccess: () => Navigator.of(context).pop(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocListener<JourneyCubit, JourneyState>(
        listener: (context, state) {
          if (state is JourneyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              KalmSnackbar(
                message: state.errorMessage,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is MeditationTaskPosted) {
            ScaffoldMessenger.of(context).showSnackBar(
              KalmSnackbar(
                message: 'Task ini telah selesai',
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop(true);
          } else if (state is MeditationTaskLoaded) {
            _audioPlayer.setSourceUrl(state.meditationTask.musicUrl);
          }
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: primaryText,
              ),
            ),
            title: Text(
              'PEMUTAR MEDITASI',
              style: kalmOfflineTheme.textTheme.headline1!
                  .apply(color: primaryText),
            ),
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<JourneyCubit, JourneyState>(
              builder: (builderContext, state) {
                if (state is MeditationTaskLoaded)
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 26),
                        child: CachedNetworkImage(
                          imageUrl: state.meditationTask.roundedImage.url!,
                          imageBuilder: (_, image) {
                            return Image.network(
                              state.meditationTask.roundedImage.url!,
                              scale: 1,
                            );
                          },
                          placeholder: (_, __) {
                            return CircularProgressIndicator(
                              color: primaryColor,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              MeditationMetaInfo(
                                title: state.meditationTask.name,
                                duration: '${state.meditationTask.duration}',
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    timeFormatter(
                                        _progress.toString().split(".").first),
                                    style: kalmOfflineTheme.textTheme.subtitle1!
                                        .apply(color: primaryColor),
                                  ),
                                  Text(
                                    '-' +
                                        timeFormatter(
                                            (_progress - _audioDuration)
                                                .toString()
                                                .split(".")
                                                .first),
                                    style: kalmOfflineTheme.textTheme.subtitle1!
                                        .apply(color: primaryText),
                                  ),
                                ],
                              ),
                              KalmSlider(
                                value: _progress.inSeconds.toDouble(),
                                max: _audioDuration.inSeconds.toDouble(),
                                min: 0.0,
                                onChanged: (value) {
                                  seekTo(value.toInt());
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      seekTo(_progress.inSeconds - 10);
                                    },
                                    icon: Icon(
                                      Iconsax.backward5,
                                      color: primaryText,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: accentColor,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        _playerState == PlayerState.playing
                                            ? pause()
                                            : play(
                                                state.meditationTask.musicUrl);
                                      },
                                      color: _playerState == PlayerState.playing
                                          ? primaryColor
                                          : primaryText,
                                      icon: Icon(
                                        _playerState == PlayerState.playing
                                            ? Iconsax.pause5
                                            : Iconsax.play5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  IconButton(
                                    onPressed: () {
                                      seekTo(_progress.inSeconds + 10);
                                    },
                                    icon: Icon(
                                      Iconsax.forward5,
                                      color: primaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                else
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  );
              },
            ),
          ),
        ),
      ),
    );
  }
}
