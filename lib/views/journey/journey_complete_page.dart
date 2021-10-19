import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_button.dart';

class JourneyCompletePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'JOURNEY SELESAI',
          style:
              kalmOfflineTheme.textTheme.headline1!.apply(color: primaryText),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Container(
                  child: Image.asset(
                    'assets/picture/picture-journey_1.png',
                    scale: 2.3,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 22),
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Kamu hebat! Sedikit demi sedikit kamu mengenali dirimu',
                    textAlign: TextAlign.center,
                    style: kalmOfflineTheme.textTheme.headline5!
                        .apply(color: primaryText),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    '“Karena sebenarnya yang tahu persis kita bahagia atau tidak, tulus atau tidak, hanyalah diri kita sendiri”',
                    textAlign: TextAlign.center,
                    style: kalmOfflineTheme.textTheme.subtitle2!
                        .apply(color: primaryText, fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                  child: Text(
                    'Tere Liye',
                    textAlign: TextAlign.center,
                    style: kalmOfflineTheme.textTheme.bodyText2!
                        .apply(color: primaryText),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                KalmButton(
                  width: double.infinity,
                  height: 56,
                  borderRadius: 10,
                  primaryColor: primaryColor,
                  child: Text(
                    'Kembali',
                    style: kalmOfflineTheme.textTheme.button!
                        .apply(color: tertiaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
