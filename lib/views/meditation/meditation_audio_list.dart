import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_playlist_tile.dart';

import 'meditation_player.dart';

class MeditationAudioList extends StatefulWidget {
  @override
  _MeditationAudioListState createState() => _MeditationAudioListState();
}

class _MeditationAudioListState extends State<MeditationAudioList> {
  List<Map<String, dynamic>> audioMetas = [
    {
      'mediaUrl':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3',
      'title': 'Peaceful Mind',
      'duration': 8
    },
    {
      'mediaUrl':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
      'title': 'Peaceful Mind 2',
      'duration': 5
    },
    {
      'mediaUrl':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
      'title': 'Peaceful Mind 3',
      'duration': 6
    },
    {
      'mediaUrl':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      'title': 'Peaceful Mind 4',
      'duration': 7
    },
    {
      'mediaUrl':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      'title': 'Peaceful Mind 5',
      'duration': 5
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: primaryText,
          ),
        ),
        title: Text(
          'TOPIK MUSIK',
          style:
              kalmOfflineTheme.textTheme.headline1!.apply(color: primaryText),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Column(
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
                  color: backgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: backgroundColor,
                        width: double.infinity,
                        child: Text(
                          'Kecemasan',
                          textAlign: TextAlign.center,
                          style: kalmOfflineTheme.textTheme.headline3!
                              .apply(color: primaryText),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        color: backgroundColor,
                        width: double.infinity,
                        child: Text(
                          '10 Menit',
                          textAlign: TextAlign.center,
                          style: kalmOfflineTheme.textTheme.subtitle1!
                              .apply(color: primaryText.withOpacity(0.5)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: 54,
                        color: backgroundColor,
                        width: double.infinity,
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
                              'Ketenangan yang terlatih akan membungkus rasa gelisah, cemas, dan takutnya dengan baik.',
                              style:
                                  kalmOfflineTheme.textTheme.subtitle1!.apply(
                                fontStyle: FontStyle.italic,
                                color: primaryText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      color: backgroundColor,
                      child: Text(
                        'Playlist',
                        style: kalmOfflineTheme.textTheme.bodyText1!
                            .apply(color: primaryText, fontSizeFactor: 1.2),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: audioMetas.length,
                          shrinkWrap: true,
                          primary: true,
                          padding: const EdgeInsets.only(top: 10),
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: KalmPlaylistTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MeditationPlayer(
                                      audioMetas: audioMetas,
                                      audioIndex: index,
                                    ),
                                  ),
                                );
                              },
                              icon: Iconsax.play,
                              tileColor: tertiaryColor,
                              iconColor: primaryColor,
                              iconBackgroundColor: tertiaryColor,
                              title: audioMetas[index]['title'],
                              subtitle:
                                  '${audioMetas[index]['duration']} menit',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
