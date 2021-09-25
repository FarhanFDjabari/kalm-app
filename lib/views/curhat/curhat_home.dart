import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/views/curhat/curhat_detail_page.dart';
import 'package:kalm/views/curhat/post_curhat_page.dart';
import 'package:kalm/widgets/kalm_chip_button.dart';
import 'package:kalm/widgets/kalm_curhat_tile.dart';
import 'package:kalm/widgets/kalm_text_button.dart';

class CurhatHome extends StatefulWidget {
  @override
  _CurhatHomeState createState() => _CurhatHomeState();
}

class _CurhatHomeState extends State<CurhatHome>
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
            Icons.menu,
            color: primaryText,
          ),
        ),
        title: Text(
          'CURHAT',
          style:
              kalmOfflineTheme.textTheme.headline1!.apply(color: primaryText),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
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
                  scale: 1.5,
                ),
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 30,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: KalmChipButton(
                            borderRadius: 40,
                            width: 70,
                            height: 26,
                            activeColor: primaryColor,
                            color: accentColor,
                            text: 'Terbaru',
                            textSize: 13,
                            staticMode: false,
                            callback: () {},
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Keuangan',
                            style: kalmOfflineTheme.textTheme.bodyText2!
                                .apply(color: primaryText),
                          ),
                        ),
                        KalmTextButton(
                          width: 120,
                          height: 20,
                          primaryColor: primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Lihat Semua',
                                style: kalmOfflineTheme.textTheme.bodyText2!
                                    .apply(color: primaryText),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: primaryText,
                                size: 16,
                              )
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 252,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (_, index) {
                        return KalmCurhatTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CurhatDetailPage(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Self-care',
                            style: kalmOfflineTheme.textTheme.bodyText2!
                                .apply(color: primaryText),
                          ),
                        ),
                        KalmTextButton(
                          width: 120,
                          height: 20,
                          primaryColor: primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Lihat Semua',
                                style: kalmOfflineTheme.textTheme.bodyText2!
                                    .apply(color: primaryText),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: primaryText,
                                size: 16,
                              )
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 252,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (_, index) {
                        return KalmCurhatTile();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        tooltip: 'Post Curhatan Baru',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PostCurhatPage(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: tertiaryColor,
          size: 24,
        ),
      ),
    );
  }
}
