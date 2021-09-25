import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/views/mood_tracker/mood_camera.dart';
import 'package:kalm/views/mood_tracker/mood_factor_page.dart';
import 'package:kalm/widgets/kalm_button.dart';
import 'package:kalm/widgets/kalm_slider.dart';

class MoodTrackerPage extends StatefulWidget {
  @override
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage> {
  int moodValue = 0;

  getMoodImage(int value) {
    switch (value) {
      case 0:
        return 'assets/picture/picture-moodtracker_buruk.png';
      case 1:
        return 'assets/picture/picture-moodtracker_biasaaja.png';
      case 2:
        return 'assets/picture/picture-moodtracker_baik.png';
    }
  }

  getMoodValue(int value) {
    switch (value) {
      case 0:
        return 'Buruk';
      case 1:
        return 'Biasa';
      case 2:
        return 'Baik';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/picture/picture-background_bottom_middle.png',
            ),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Iconsax.menu,
                    color: primaryText,
                  ),
                ),
                title: Text(
                  'MOOD TRACKER',
                  style: kalmOfflineTheme.textTheme.headline1!.apply(
                    color: primaryText,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  'Hai Selen',
                  style: kalmOfflineTheme.textTheme.bodyText1!
                      .apply(color: primaryText, fontSizeFactor: 1.2),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: Text(
                  'Bagaimana perasaanmu hari ini?',
                  style: kalmOfflineTheme.textTheme.headline1!
                      .apply(color: primaryText, fontSizeFactor: 1.1),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  getMoodImage(moodValue).toString(),
                  scale: 1.7,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 22),
                child: Text(
                  getMoodValue(moodValue),
                  style: kalmOfflineTheme.textTheme.headline1!
                      .apply(color: primaryText, fontSizeFactor: 1.1),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Buruk'),
                        Text('Baik'),
                      ],
                    ),
                    KalmSlider(
                      onChanged: (value) {
                        setState(() {
                          moodValue = value.toInt();
                        });
                      },
                      trackHeight: 8,
                      inactiveColor: tertiaryColor,
                      value: moodValue.toDouble(),
                      max: 2,
                      min: 0,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  children: [
                    Expanded(
                      child: KalmButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => MoodCamera()),
                          );
                        },
                        primaryColor: tertiaryColor,
                        height: MediaQuery.of(context).size.height * 0.085,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.scan,
                              color: primaryColor,
                              size: 28,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Kenali Perasaanmu',
                              style: kalmOfflineTheme.textTheme.button!.apply(
                                  color: primaryColor, fontSizeFactor: 1.1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    KalmButton(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.085,
                      primaryColor: primaryColor,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: tertiaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MoodFactorPage(),
                        ));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
