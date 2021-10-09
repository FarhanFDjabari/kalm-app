import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/dominasi_mood_tile.dart';
import 'package:kalm/widgets/kalm_mood_graph.dart';

class WeeklyMoodTab extends StatefulWidget {
  @override
  _WeeklyMoodTabState createState() => _WeeklyMoodTabState();
}

class _WeeklyMoodTabState extends State<WeeklyMoodTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(8),
                  splashColor: tertiaryColor,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: tertiaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '08 Okt 2021 - 15 Okt 2021',
                      style: kalmOfflineTheme.textTheme.bodyText2!
                          .copyWith(
                              fontWeight: FontWeight.bold, color: primaryColor)
                          .apply(fontSizeFactor: 1.15),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(8),
                  splashColor: tertiaryColor,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: tertiaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                'Dominasi Emosimu',
                style: kalmOfflineTheme.textTheme.button!
                    .apply(color: primaryText, fontSizeFactor: 1.1),
              ),
            ),
            DominasiMoodTile(),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                'Grafik Moodmu',
                style: kalmOfflineTheme.textTheme.button!
                    .apply(color: primaryText, fontSizeFactor: 1.1),
              ),
            ),
            KalmMoodGraph(),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                'Akumulasi Faktor Moodmu',
                style: kalmOfflineTheme.textTheme.button!
                    .apply(color: primaryText, fontSizeFactor: 1.1),
              ),
            ),
            Expanded(
              child: Material(
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      tileColor: tertiaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      leading: Icon(
                        Iconsax.briefcase,
                        color: primaryColor,
                        size: 28,
                      ),
                      title: Text(
                        'Pekerjaan',
                        style: kalmOfflineTheme.textTheme.bodyText1!
                            .apply(color: primaryText, fontSizeFactor: 1.2),
                      ),
                      trailing: Text(
                        '2',
                        style: kalmOfflineTheme.textTheme.bodyText1!
                            .apply(color: secondaryText, fontSizeFactor: 1.2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
