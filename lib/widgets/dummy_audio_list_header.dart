import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class DummyAudioListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 26),
          child: Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        ),
        Container(
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: backgroundColor,
                width: double.infinity,
                child: Text(
                  '-',
                  textAlign: TextAlign.center,
                  style: kalmOfflineTheme.textTheme.headline3!
                      .apply(color: primaryText),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                color: backgroundColor,
                width: double.infinity,
                child: Text(
                  '- Seri',
                  textAlign: TextAlign.center,
                  style: kalmOfflineTheme.textTheme.subtitle1!
                      .apply(color: primaryText.withOpacity(0.5)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 50),
                height: 54,
                color: backgroundColor,
                width: double.infinity,
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
                      '-',
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
          ),
        ),
      ],
    );
  }
}
