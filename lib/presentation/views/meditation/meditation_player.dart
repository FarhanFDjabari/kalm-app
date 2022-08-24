import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kalm/domain/entity/meditation/playlist_music_item_entity.dart';
import 'package:kalm/presentation/widgets/kalm_audio_player.dart';
import 'package:kalm/presentation/widgets/kalm_dialog.dart';
import 'package:kalm/styles/kalm_theme.dart';

class MeditationPlayer extends StatefulWidget {
  final int audioIndex;
  final List<PlaylistMusicItemEntity> musicList;

  MeditationPlayer({this.audioIndex = 0, required this.musicList});

  @override
  _MeditationPlayerState createState() => _MeditationPlayerState();
}

class _MeditationPlayerState extends State<MeditationPlayer> {
  Future<bool> onWillPop() async {
    final shouldPop = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => KalmDialog(
        title: 'Apakah kamu yakin akan keluar dari pemutar meditasi?',
        successButtonTitle: 'Keluar',
        cancelButtonTitle: 'Batalkan',
        onCancel: () => Navigator.of(context).pop(false),
        onSuccess: () => Navigator.of(context).pop(true),
      ),
    );

    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: primaryText,
          ),
        ),
        title: Text(
          'PEMUTAR MEDITASI',
          style:
              kalmOfflineTheme.textTheme.headline1!.apply(color: primaryText),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 26),
              child: CachedNetworkImage(
                imageUrl:
                    widget.musicList[widget.audioIndex].roundedImage!.url!,
                imageBuilder: (_, image) {
                  return Image.network(
                    widget.musicList[widget.audioIndex].roundedImage!.url!,
                    scale: 1.8,
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
                child: KalmAudioPlayer(
                  onWillPop: onWillPop,
                  musicList: widget.musicList,
                  audioIndex: widget.audioIndex,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
