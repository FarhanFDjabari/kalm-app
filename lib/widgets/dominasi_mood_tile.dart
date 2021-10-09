import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class DominasiMoodTile extends StatelessWidget {
  const DominasiMoodTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset(
                        'assets/picture/picture-mood_baik.png',
                        scale: 2.5,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Baik',
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
            color: secondaryText.withOpacity(0.75),
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
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          child: Icon(
                            Iconsax.briefcase,
                            color: primaryColor,
                            size: 36,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Pekerjaan',
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
