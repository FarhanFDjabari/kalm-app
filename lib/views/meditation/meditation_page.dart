import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_chip_button.dart';
import 'package:kalm/widgets/kalm_icon_button.dart';
import 'package:kalm/widgets/kalm_text_button.dart';
import 'package:kalm/widgets/meditation_header_tile.dart';

class MeditationPage extends StatefulWidget {
  @override
  _MeditationPageState createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Iconsax.menu,
            color: primaryText,
          ),
        ),
        title: Text(
          'MEDITASI',
          style: kalmOfflineTheme.textTheme.headline1!.apply(
            color: primaryText,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Iconsax.frame,
              color: primaryText,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          MeditationHeaderTile(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Topik Musik Meditasi',
                  style: kalmOfflineTheme.textTheme.bodyText1!
                      .apply(color: primaryText, fontSizeFactor: 1.2),
                ),
                KalmTextButton(
                  width: 130,
                  height: 20,
                  primaryColor: primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Lihat Semua',
                        style: kalmOfflineTheme.textTheme.bodyText1!
                            .apply(color: primaryText, fontSizeFactor: 1.2),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: primaryText,
                        size: 18,
                      )
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 90,
            child: ListView.builder(
              itemCount: 6,
              itemExtent: 115,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => KalmIconButton(
                width: 100,
                height: 100,
                iconRadius: 60,
                iconSize: 24,
                fontSize: 14,
                label: 'Relaksasi',
                icon: Icons.book_outlined,
                iconSelected: Icons.book,
                primaryColor: primaryColor,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              color: primaryColor,
              child: ListView.builder(
                itemCount: 3,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (_, index) => Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.17,
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
                            'assets/picture/picture-topik_meditasi_1.png',
                            scale: 1.7,
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hembuskan Nafas',
                                  style: kalmOfflineTheme.textTheme.bodyText1!
                                      .apply(
                                    color: primaryText,
                                    fontSizeFactor: 1.2,
                                  ),
                                ),
                                KalmChipButton(
                                  borderRadius: 50,
                                  width: 80,
                                  height: 26,
                                  activeColor: primaryColor,
                                  staticMode: true,
                                  color: accentColor,
                                  text: '10 menit',
                                  textSize: 13,
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              padding: const EdgeInsets.only(right: 30),
                              child: Text(
                                '3 menit pengantar untuk meditasi. Relaks dan tarik napas untuk memulai',
                                style: kalmOfflineTheme.textTheme.subtitle1!
                                    .apply(
                                        color: secondaryText,
                                        fontSizeFactor: 1.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
