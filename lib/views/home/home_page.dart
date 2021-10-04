import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_meditation_tile.dart';
import 'package:kalm/widgets/kalm_mood_widget.dart';
import 'package:kalm/widgets/kalm_text_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> moodData = [
    {
      'imagePath': 'assets/picture/picture-facerecognition_buruk.png',
      'label': 'Buruk',
    },
    {
      'imagePath': 'assets/picture/picture-facerecognition_biasa.png',
      'label': 'Biasa',
    },
    {
      'imagePath': 'assets/picture/picture-facerecognition_baik.png',
      'label': 'Baik',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: primaryText,
          ),
        ),
        title: Text(
          'HOME',
          style: kalmOfflineTheme.textTheme.headline1!.apply(
            color: primaryText,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Iconsax.notification5,
              color: primaryText,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Pagi, Andini',
              style: kalmOfflineTheme.textTheme.bodyText1!
                  .apply(color: primaryText, fontSizeFactor: 1.2),
            ),
            SizedBox(height: 8),
            Text(
              'Bagaimana perasaanmu hari ini?',
              style: kalmOfflineTheme.textTheme.headline1!
                  .apply(color: primaryText, fontSizeFactor: 1.2),
            ),
            SizedBox(height: 8),
            KalmMoodWidget(moodData: moodData),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    'Rekomendasi meditasi',
                    style: kalmOfflineTheme.textTheme.bodyText2!
                        .apply(color: primaryText, fontSizeFactor: 1.1),
                  ),
                ),
                KalmTextButton(
                  width: 120,
                  height: 20,
                  primaryColor: primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Lihat Semua',
                        style: kalmOfflineTheme.textTheme.bodyText2!
                            .apply(color: primaryText, fontSizeFactor: 1.1),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: primaryText,
                        size: 16,
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (_, index) => KalmMeditationTile(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
