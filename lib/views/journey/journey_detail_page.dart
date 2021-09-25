import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/views/journey/journey_chapter_page.dart';
import 'package:kalm/widgets/kalm_playlist_tile.dart';

class JourneyDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/picture/picture-background_top_middle.png',
                scale: 1.5,
              ),
            ),
            Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: primaryText,
                    ),
                  ),
                  title: Text(
                    'JOURNEY',
                    style: kalmOfflineTheme.textTheme.headline1!
                        .apply(color: primaryText),
                  ),
                ),
                Container(
                  child: Image.asset(
                    'assets/picture/picture-journey_1.png',
                    scale: 2.3,
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  height: 17,
                  child: Container(color: backgroundColor),
                ),
                Container(
                  color: backgroundColor,
                  width: double.infinity,
                  child: Text(
                    'Mengenali Diriku',
                    style: kalmOfflineTheme.textTheme.button!
                        .apply(color: primaryText),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 8,
                  child: Container(color: backgroundColor),
                ),
                Container(
                  color: backgroundColor,
                  width: double.infinity,
                  child: Text(
                    'Oleh Marina Mahendra, S.Psi, M.Psi',
                    style: kalmOfflineTheme.textTheme.subtitle1!
                        .apply(color: secondaryText),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 8,
                  child: Container(color: backgroundColor),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  color: backgroundColor,
                  child: Text(
                    'Kenali diri dan mulai mensyukuri segala hal. Lihat kelebihan dan kekurangan yang ada di dalam dirimu',
                    style: kalmOfflineTheme.textTheme.subtitle2!
                        .apply(color: primaryText),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 16,
                  child: Container(color: backgroundColor),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    color: backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Kegiatan 04 September 2021',
                          style: kalmOfflineTheme.textTheme.bodyText1!
                              .apply(color: primaryText),
                        ),
                        Text(
                          '1/5',
                          style: kalmOfflineTheme.textTheme.bodyText1!
                              .apply(color: primaryText),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView.builder(
                      itemCount: 5,
                      padding: const EdgeInsets.only(top: 10),
                      itemBuilder: (_, index) => Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: KalmPlaylistTile(
                          icon: Icons.flag,
                          iconBackgroundColor: accentColor,
                          iconColor: primaryColor,
                          title: 'Mood Tracker',
                          subtitle: 'Bagaimana perasaanmu hari ini?',
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JourneyChapterPage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: primaryText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
