import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/views/journey/journey_detail_page.dart';
import 'package:kalm/widgets/kalm_button.dart';
import 'package:kalm/widgets/kalm_journey_image_card.dart';

class JourneyPage extends StatefulWidget {
  @override
  _JourneyPageState createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage>
    with AutomaticKeepAliveClientMixin {
  int currentIndex = 0;

  @override
  bool get wantKeepAlive => true;

  List<Map<String, String>> journeyList = [
    {
      'imagePath': 'assets/picture/picture-journey_1.png',
      'title': 'Mengenali Diriku',
      'author': 'Marina Mahendra, S.Psi, M.Psi, Psikolog, C.Ht',
      'description':
          'Kenali diri dan mulai mensyukuri segala hal. Lihat kelebihan dan kekurangan yang ada di dalam dirimu',
    },
    {
      'imagePath': 'assets/picture/picture-journey_2.png',
      'title': 'Mengenali Diriku 2',
      'author': 'Marina Mahendra, S.Psi, M.Psi, Psikolog, C.Ht',
      'description':
          'Kenali diri dan mulai mensyukuri segala hal. Lihat kelebihan dan kekurangan yang ada di dalam dirimu',
    },
    {
      'imagePath': 'assets/picture/picture-journey_3.png',
      'title': 'Mengenali Diriku 3',
      'author': 'Marina Mahendra, S.Psi, M.Psi, Psikolog, C.Ht',
      'description':
          'Kenali diri dan mulai mensyukuri segala hal. Lihat kelebihan dan kekurangan yang ada di dalam dirimu',
    },
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: backgroundColor,
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
            Column(
              children: [
                AppBar(
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
                    'JOURNEY',
                    style: kalmOfflineTheme.textTheme.headline1!.apply(
                      color: primaryText,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Swiper(
                    scrollDirection: Axis.horizontal,
                    itemHeight: MediaQuery.of(context).size.height * 0.85,
                    itemCount: journeyList.length,
                    onIndexChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    viewportFraction: 0.85,
                    scale: 0.65,
                    loop: false,
                    itemBuilder: (_, index) => Column(
                      children: [
                        KalmJourneyImageCard(
                          journeyList: journeyList,
                          index: index,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: tertiaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    journeyList[index]['title']!,
                                    style: kalmOfflineTheme.textTheme.button!
                                        .apply(
                                            color: primaryText,
                                            fontSizeFactor: 1.1),
                                  ),
                                  Text(
                                    'Progress 1/3',
                                    style: kalmOfflineTheme.textTheme.button!
                                        .apply(color: primaryColor),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                journeyList[index]['author']!,
                                style: kalmOfflineTheme.textTheme.bodyText1!
                                    .apply(color: secondaryText),
                              ),
                              SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  journeyList[index]['description']!,
                                  style: kalmOfflineTheme.textTheme.subtitle1!
                                      .apply(
                                          color: primaryText,
                                          fontSizeFactor: 1.1),
                                ),
                              ),
                              SizedBox(height: 12),
                              KalmButton(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.065,
                                primaryColor: primaryColor,
                                borderRadius: 10,
                                child: Text(
                                  'Mulai Journey',
                                  style: kalmOfflineTheme.textTheme.bodyText1!
                                      .apply(color: tertiaryColor),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => JourneyDetailPage(),
                                  ));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
