import 'package:flutter/material.dart';
import 'package:kalm/domain/entity/meditation/playlist_music_item_entity.dart';
import 'package:kalm/presentation/views/meditation/meditation_player.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/styles/kalm_theme.dart';

class MeditationHeaderTile extends StatelessWidget {
  const MeditationHeaderTile({
    Key? key,
    this.musicList,
  }) : super(key: key);

  final List<PlaylistMusicItemEntity>? musicList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(
            'assets/picture/picture-meditasi_1.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              'Untuk kamu di \nhari ini',
              style: kalmOfflineTheme.textTheme.headline2!
                  .apply(color: primaryText, fontSizeFactor: 1.2),
            ),
          ),
          SizedBox(height: 14),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.1,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tertiaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      musicList![0].name ?? '-',
                      style: kalmOfflineTheme.textTheme.subtitle1!
                          .apply(color: primaryText, fontSizeFactor: 1.2),
                    ),
                    Text(
                      musicList![0].duration ?? '-',
                      style: kalmOfflineTheme.textTheme.subtitle1!
                          .apply(color: secondaryText, fontSizeFactor: 1.2),
                    )
                  ],
                ),
                CircleAvatar(
                  backgroundColor: accentColor,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeditationPlayer(
                            musicList: musicList!,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Iconsax.play5,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
