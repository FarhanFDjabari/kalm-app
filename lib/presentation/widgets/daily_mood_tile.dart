import 'package:flutter/material.dart';
import 'package:kalm/data/model/mood_tracker/mood_tracker_daily_insight_model.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/styles/kalm_theme.dart';

class DailyMoodTile extends StatelessWidget {
  const DailyMoodTile({
    Key? key,
    required this.moodPoint,
    required this.reasons,
  }) : super(key: key);

  final int moodPoint;
  final List<Reason> reasons;

  String getMoodAsset(int? moodPoint) {
    if (moodPoint == 0) {
      return 'assets/picture/picture-mood_buruk.png';
    } else if (moodPoint == 1) {
      return 'assets/picture/picture-mood_biasa.png';
    } else {
      return 'assets/picture/picture-mood_baik.png';
    }
  }

  String moodPointToLabel(int? moodPoint) {
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
      height: MediaQuery.of(context).size.height * 0.25,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: tertiaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: Text(
                  'Mood',
                  style: kalmOfflineTheme.textTheme.bodyText1!
                      .apply(color: secondaryText, fontSizeFactor: 1.1),
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
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
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: Text(
                  'Faktor',
                  style: kalmOfflineTheme.textTheme.bodyText1!
                      .apply(color: secondaryText, fontSizeFactor: 1.1),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.62,
                height: MediaQuery.of(context).size.height * 0.14,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 8,
                    mainAxisExtent: MediaQuery.of(context).size.width * 0.29,
                    childAspectRatio: 0.25,
                  ),
                  itemCount: reasons.length,
                  itemBuilder: (_, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: accentColor,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Icon(
                            getMoodFactorIcon(reasons[index].reason),
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          reasons[index].reason ?? 'Pekerjaan',
                          style: kalmOfflineTheme.textTheme.bodyText1!.apply(
                            color: primaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
