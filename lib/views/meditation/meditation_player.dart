import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_audio_player.dart';
import 'package:kalm/widgets/kalm_dialog.dart';

class MeditationPlayer extends StatefulWidget {
  final int audioIndex;
  final List<Map<String, dynamic>> audioMetas;

  MeditationPlayer({this.audioIndex = 0, required this.audioMetas});

  @override
  _MeditationPlayerState createState() => _MeditationPlayerState();
}

class _MeditationPlayerState extends State<MeditationPlayer> {
  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
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
              child: Image.asset(
                'assets/picture/picture-topik_meditasi_4.png',
                scale: 1.8,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: KalmAudioPlayer(
                  onWillPop: onWillPop,
                  audioMetas: widget.audioMetas,
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
