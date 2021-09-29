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
          margin: const EdgeInsets.only(top: 37),
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
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 50),
          height: 54,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  'assets/picture/picture-quotation.png',
                  scale: 2,
                ),
              ),
              Text(
                'Penyesalan tidak pernah mengubah masa lalu. kecemasan tidak pernah mengubah masa depan.',
                style: kalmOfflineTheme.textTheme.subtitle1!.apply(
                  fontStyle: FontStyle.italic,
                  color: primaryText,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
