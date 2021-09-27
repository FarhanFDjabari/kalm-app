import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_audio_player.dart';
import 'package:kalm/widgets/kalm_dialog.dart';

class MeditationPlayer extends StatefulWidget {
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
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 26),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryColor),
                ),
                child: Image.asset(
                  'assets/picture/picture-topik_meditasi_4.png',
                  scale: 1.8,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 37),
                child: Text(
                  'Peaceful Mind',
                  style: kalmOfflineTheme.textTheme.headline3!
                      .apply(color: primaryText),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: Text(
                  '10 Menit',
                  style: kalmOfflineTheme.textTheme.subtitle1!
                      .apply(color: primaryText.withOpacity(0.5)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 50),
                height: 54,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/picture/picture-quotation.png',
                        scale: 2,
                      ),
                    ),
                    Text(
                      'Penyesalan tidak pernah mengubah masa lalu. kecemasan tidak pernah mengubah masa depan.',
                      style: kalmOfflineTheme.textTheme.subtitle1!.apply(
                        fontStyle: FontStyle.italic,
                        color: primaryText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 14),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: KalmAudioPlayer(
                    onWillPop: onWillPop,
                    mediaUrl:
                        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
