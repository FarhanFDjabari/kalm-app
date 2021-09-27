import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_button.dart';
import 'package:kalm/widgets/mood_factor_tile.dart';

class MoodFactorPage extends StatefulWidget {
  @override
  _MoodFactorPageState createState() => _MoodFactorPageState();
}

class _MoodFactorPageState extends State<MoodFactorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: primaryText,
          ),
        ),
        title: Text(
          'MOOD TRACKER',
          style: kalmOfflineTheme.textTheme.headline1!.apply(
            color: primaryText,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/picture/picture-background_bottom_middle.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Apa yang membuat harimu terasa buruk?',
                      style: kalmOfflineTheme.textTheme.headline1!
                          .apply(color: primaryText, fontSizeFactor: 1.1),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: 8,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => MoodFactorTile(),
                    ),
                  ),
                  KalmButton(
                    width: double.infinity,
                    height: 56,
                    child: Text(
                      'Lihat grafik',
                      style: kalmOfflineTheme.textTheme.button!
                          .apply(color: tertiaryColor, fontSizeFactor: 1.2),
                    ),
                    primaryColor: primaryColor,
                    borderRadius: 10,
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
