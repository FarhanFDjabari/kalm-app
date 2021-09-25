import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';

import 'kalm_chip_button.dart';

class KalmJourneyImageCard extends StatelessWidget {
  const KalmJourneyImageCard({
    Key? key,
    required this.journeyList,
    required this.index,
  }) : super(key: key);

  final List<Map<String, String>> journeyList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Stack(
        children: [
          Image.asset(
            journeyList[index]['imagePath']!,
          ),
          Positioned(
            bottom: 85,
            right: 20,
            child: KalmChipButton(
              borderRadius: 40,
              staticMode: true,
              width: 78,
              height: 26,
              activeColor: accentColor,
              color: primaryColor,
              text: 'Progress 1/3',
              textSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
