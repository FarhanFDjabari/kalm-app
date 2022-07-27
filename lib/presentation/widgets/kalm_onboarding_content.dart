import 'package:flutter/material.dart';
import 'package:kalm/styles/kalm_theme.dart';

class KalmOnboardingContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const KalmOnboardingContent({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: 1),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Image.asset(
            imagePath,
            scale: 1.8,
          ),
        ),
        Spacer(flex: 1),
        Container(
          child: Text(
            title,
            style: kalmOfflineTheme.textTheme.headline4!
                .apply(color: primaryText, fontSizeFactor: 1.1),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 50),
          width: double.infinity,
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: kalmOfflineTheme.textTheme.subtitle2!
                .apply(color: primaryText, fontSizeFactor: 1.1),
          ),
        ),
      ],
    );
  }
}
