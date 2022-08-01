import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:kalm/domain/entity/meditation/playlist_music_item_entity.dart';
import 'package:kalm/presentation/widgets/kalm_playlist_tile.dart';
import 'package:kalm/presentation/widgets/kalm_slider.dart';
import 'package:kalm/presentation/widgets/meditation_meta_info.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/styles/kalm_theme.dart';

class KalmAudioPlayer extends StatefulWidget {
  final int audioIndex;
  final List<PlaylistMusicItemEntity> musicList;
  final Future<bool> Function() onWillPop;

  KalmAudioPlayer({
    required this.onWillPop,
    this.audioIndex = 0,
    required this.musicList,
  });

  @override
  _KalmAudioPlayerState createState() => _KalmAudioPlayerState();
}

class _KalmAudioPlayerState extends State<KalmAudioPlayer> {
  AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState _playerState = PlayerState.paused;
  Duration _progress = Duration();
  Duration _audioDuration = Duration();
  int playIndex = 0;

  @override
  void initState() {
    super.initState();
    playIndex = widget.audioIndex;
    _audioPlayer.setSourceUrl(widget.musicList[playIndex].musicUrl!);

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
      if (playIndex < widget.musicList.length - 1) {
        setState(() {
          _progress = Duration(seconds: 0);
          next();
        });
      } else {
        setState(() {
          _progress = Duration(seconds: 0);
          _audioPlayer.stop();
        });
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    disposeAudio();
  }

  next() async {
    await _audioPlayer.stop();
    if (playIndex < widget.musicList.length - 1) {
      await _audioPlayer.setSourceUrl(widget.musicList[++playIndex].musicUrl!);
      play(playIndex);
    }
  }

  play(int index) async {
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.onWillPop,
      child: Column(
        children: [
          MeditationMetaInfo(
            title: widget.musicList[playIndex].name!,
            duration: '${widget.musicList[playIndex].duration}',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                timeFormatter(_progress.toString().split(".").first),
                style: kalmOfflineTheme.textTheme.subtitle1!
                    .apply(color: primaryColor),
              ),
              Text(
                '-' +
                    timeFormatter((_progress - _audioDuration)
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  enableDrag: false,
                  isDismissible: true,
                  builder: (context) => BottomSheet(
                    backgroundColor: tertiaryColor,
                    enableDrag: false,
                    onClosing: () {
                      print('close');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: backgroundColor,
                                child: Text(
                                  'Playlist',
                                  style: kalmOfflineTheme.textTheme.bodyText1!
                                      .apply(
                                          color: primaryText,
                                          fontSizeFactor: 1.2),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.close),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                itemCount: widget.musicList.length,
                                shrinkWrap: true,
                                primary: true,
                                padding: const EdgeInsets.only(top: 10),
                                itemBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: KalmPlaylistTile(
                                    onTap: () async {
                                      playIndex = index;
                                      await _audioPlayer.stop();
                                      _progress = Duration();
                                      if (playIndex <
                                          widget.musicList.length - 1) {
                                        await _audioPlayer.setSourceUrl(widget
                                            .musicList[playIndex].musicUrl!);
                                      }
                                      setState(() {
                                        Navigator.of(context).pop(false);
                                      });
                                    },
                                    icon: index == playIndex
                                        ? Iconsax.pause
                                        : Iconsax.play,
                                    tileColor: tertiaryColor,
                                    iconColor: primaryColor,
                                    iconBackgroundColor: accentColor,
                                    title: widget.musicList[index].name!,
                                    subtitle:
                                        '${widget.musicList[index].duration}',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                icon: Icon(
                  Iconsax.menu_14,
                  color: primaryText,
                ),
              ),
              Row(
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
                            : play(playIndex);
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
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.archive_1,
                  color: primaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
