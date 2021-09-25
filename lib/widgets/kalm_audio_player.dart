import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';

import 'kalm_slider.dart';

class KalmAudioPlayer extends StatefulWidget {
  final String mediaUrl;
  final Future<bool> Function() onWillPop;

  KalmAudioPlayer({
    required this.mediaUrl,
    required this.onWillPop,
  });

  @override
  _KalmAudioPlayerState createState() => _KalmAudioPlayerState();
}

class _KalmAudioPlayerState extends State<KalmAudioPlayer> {
  AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState _playerState = PlayerState.PAUSED;
  Duration _progress = Duration();
  Duration _audioDuration = Duration();

  @override
  void initState() {
    super.initState();
    _audioPlayer.setUrl(widget.mediaUrl);

    _audioPlayer.onPlayerStateChanged.listen((audioState) {
      if (audioState == PlayerState.STOPPED) {
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

    _audioPlayer.onAudioPositionChanged.listen((currentPosition) {
      setState(() {
        _progress = currentPosition;
      });
    });

    _audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _progress = Duration(seconds: 0);
        _audioPlayer.stop();
      });
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    disposeAudio();
  }

  play() async {
    await _audioPlayer.play(widget.mediaUrl);
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
                onPressed: () {},
                icon: Icon(
                  Iconsax.menu4,
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
                      Iconsax.backward4,
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
                        _playerState == PlayerState.PLAYING ? pause() : play();
                      },
                      color: _playerState == PlayerState.PLAYING
                          ? primaryColor
                          : primaryText,
                      icon: Icon(
                        _playerState == PlayerState.PLAYING
                            ? Iconsax.pause5
                            : Iconsax.play,
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
                  Iconsax.frame4,
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
