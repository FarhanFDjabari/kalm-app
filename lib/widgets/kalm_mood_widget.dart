import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/views/mood_tracker/mood_factor_page.dart';

import 'kalm_button.dart';
import 'kalm_outlined_button.dart';

class KalmMoodWidget extends StatefulWidget {
  const KalmMoodWidget({
    Key? key,
    required this.moodData,
  }) : super(key: key);

  final List<Map<String, String>> moodData;

  @override
  _KalmMoodWidgetState createState() => _KalmMoodWidgetState();
}

class _KalmMoodWidgetState extends State<KalmMoodWidget> {
  int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: tertiaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.moodData
                .map(
                  (mood) => buildMoodWidgetItem(mood, context),
                )
                .toList(),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: KalmOutlinedButton(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.085,
                  borderRadius: 10,
                  primaryColor: primaryColor,
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
                        style: kalmOfflineTheme.textTheme.button!
                            .apply(color: primaryColor, fontSizeFactor: 1.1),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 10,
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
        ],
      ),
    );
  }

  InkWell buildMoodWidgetItem(Map<String, String> mood, BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        setState(() {
          selectedIndex = widget.moodData.indexOf(mood);
        });
      },
      splashColor: accentColor,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 350),
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.15,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: widget.moodData.indexOf(mood) == selectedIndex
              ? accentColor
              : tertiaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              mood['imagePath']!,
            ),
            SizedBox(height: 10),
            Text(
              mood['label']!,
              style: widget.moodData.indexOf(mood) == selectedIndex
                  ? kalmOfflineTheme.textTheme.bodyText1!
                      .apply(color: primaryColor, fontSizeFactor: 1.2)
                  : kalmOfflineTheme.textTheme.subtitle1!
                      .apply(color: primaryText, fontSizeFactor: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}
