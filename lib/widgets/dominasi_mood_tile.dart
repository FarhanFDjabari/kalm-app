import 'package:flutter/material.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class DominasiMoodTile extends StatelessWidget {
  const DominasiMoodTile({
    Key? key,
    this.moodPoint,
    this.moodFactor,
  }) : super(key: key);

  final double? moodPoint;
  final String? moodFactor;

  String getMoodAsset(double? moodPoint) {
    if (moodPoint == 0) {
      return 'assets/picture/picture-mood_buruk.png';
    } else if (moodPoint == 1) {
      return 'assets/picture/picture-mood_biasa.png';
    } else {
      return 'assets/picture/picture-mood_baik.png';
    }
  }

  String moodPointToLabel(double? moodPoint) {
    if (moodPoint == 0) {
      return 'Buruk';
    } else if (moodPoint == 1) {
      return 'Biasa';
    } else {
      return 'Baik';
    }
  }

  IconData getMoodFactorIcon(String? moodFactor) {
    switch (moodFactor) {
      case 'Pekerjaan':
        return Iconsax.briefcase;
      case 'Tidur':
        return Iconsax.moon;
      case 'Hubungan':
        return Iconsax.lovely;
      case 'Keluarga':
        return Iconsax.home_2;
      case 'Teman':
        return Iconsax.profile_2user;
      case 'Pendidikan':
        return Iconsax.teacher;
      case 'Finansial':
        return Iconsax.empty_wallet;
      default:
        return Iconsax.bubble;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: tertiaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mood',
                    style: kalmOfflineTheme.textTheme.bodyText1!
                        .apply(color: secondaryText, fontSizeFactor: 1.1),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Image.asset(
                        getMoodAsset(moodPoint),
                        scale: 3.2,
                      ),
                      SizedBox(width: 10),
                      Text(
                        moodPointToLabel(moodPoint),
                        style: kalmOfflineTheme.textTheme.bodyText1!
                            .apply(color: primaryText, fontSizeFactor: 1.1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            color: secondaryText.withOpacity(0.55),
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Faktor',
                    style: kalmOfflineTheme.textTheme.bodyText1!
                        .apply(color: secondaryText, fontSizeFactor: 1.1),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          child: Icon(
                            getMoodFactorIcon(moodFactor),
                            color: primaryColor,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          moodFactor ?? 'Pekerjaan',
                          style: kalmOfflineTheme.textTheme.bodyText1!
                              .apply(color: primaryText, fontSizeFactor: 1.1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
