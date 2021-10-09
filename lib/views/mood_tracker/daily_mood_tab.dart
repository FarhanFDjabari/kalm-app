import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/daily_mood_tile.dart';

class DailyMoodTab extends StatefulWidget {
  @override
  _DailyMoodTabState createState() => _DailyMoodTabState();
}

class _DailyMoodTabState extends State<DailyMoodTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Senin, 08 Oktober 2021',
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Moodmu Hari Ini',
                  style: kalmOfflineTheme.textTheme.button!
                      .apply(color: primaryText, fontSizeFactor: 1.1),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Iconsax.edit_25,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          DailyMoodTile(),
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Rekomendasi Meditasi',
              style: kalmOfflineTheme.textTheme.button!
                  .apply(color: primaryText, fontSizeFactor: 1.1),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 0.45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (_, index) => Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.width * 0.4,
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: tertiaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/picture/picture-onboarding_2.png',
                      scale: 3,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Keheningan',
                      style: kalmOfflineTheme.textTheme.bodyText1!
                          .apply(color: primaryText, fontSizeFactor: 1.1),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '10 Menit',
                      style: kalmOfflineTheme.textTheme.bodyText1!.apply(
                        color: secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
