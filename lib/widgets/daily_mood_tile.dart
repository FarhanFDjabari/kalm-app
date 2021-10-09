import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class DailyMoodTile extends StatelessWidget {
  const DailyMoodTile({
    Key? key,
  }) : super(key: key);

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
                        'assets/picture/picture-mood_baik.png',
                        scale: 3.2,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Baik',
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
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: Text(
                  'Faktor',
                  style: kalmOfflineTheme.textTheme.bodyText1!
                      .apply(color: secondaryText, fontSizeFactor: 1.1),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.62,
                height: MediaQuery.of(context).size.height * 0.14,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 8,
                    mainAxisExtent: MediaQuery.of(context).size.width * 0.28,
                    childAspectRatio: 0.25,
                  ),
                  itemCount: 4,
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
                            Iconsax.briefcase,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Pekerjaan',
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
