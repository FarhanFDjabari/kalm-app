import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class MeditationMetaInfo extends StatelessWidget {
  const MeditationMetaInfo({
    Key? key,
    required this.title,
    required this.duration,
  }) : super(key: key);

  final String title;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            title,
            style:
                kalmOfflineTheme.textTheme.headline3!.apply(color: primaryText),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            duration,
            style: kalmOfflineTheme.textTheme.subtitle1!
                .apply(color: primaryText.withOpacity(0.5)),
          ),
        ),
      ],
    );
  }
}
