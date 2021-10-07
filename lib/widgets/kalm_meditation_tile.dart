import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class KalmMeditationTile extends StatelessWidget {
  const KalmMeditationTile({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.16,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: tertiaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset(
                imagePath,
                scale: 1.7,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: accentColor,
                  child: Icon(
                    Iconsax.play5,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hembuskan Nafas',
                        style: kalmOfflineTheme.textTheme.bodyText1!.apply(
                          color: primaryText,
                          fontSizeFactor: 1.2,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(
                          '3 menit pengantar untuk meditasi. Relaks dan tarik napas untuk memulai',
                          softWrap: true,
                          style: kalmOfflineTheme.textTheme.subtitle1!
                              .apply(color: secondaryText, fontSizeFactor: 1.2),
                        ),
                      ),
                    ],
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
