import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/views/auth/auth_page.dart';
import 'package:kalm/widgets/kalm_button.dart';
import 'package:kalm/widgets/kalm_onboarding_content.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  final onBoardingController = PageController(initialPage: 0);
  late Timer _onBoardingScroll;

  final List<Map<String, String>> onBoardingData = [
    {
      'title': 'Mood Tracker',
      'subtitle': 'Kenali perasanmu menggunakan AI face recognition',
      'imagePath': 'assets/picture/picture-onboarding_1.png'
    },
    {
      'title': 'Meditasi',
      'subtitle': 'Dengarkan musik-musik yang memberikan ketenangan untukmu',
      'imagePath': 'assets/picture/picture-onboarding_2.png'
    },
    {
      'title': 'Curhat',
      'subtitle': 'Kenali perasanmu menggunakan AI face recognition',
      'imagePath': 'assets/picture/picture-onboarding_1.png'
    },
    {
      'title': 'Journey',
      'subtitle': 'Dengarkan musik-musik yang memberikan ketenangan untukmu',
      'imagePath': 'assets/picture/picture-onboarding_2.png'
    },
  ];

  @override
  void initState() {
    super.initState();
    _onBoardingScroll = Timer.periodic(
      Duration(seconds: 4),
      (timer) {
        if (currentIndex < 3) {
          currentIndex++;
        } else {
          currentIndex = 0;
        }
        onBoardingController.animateToPage(currentIndex,
            duration: Duration(milliseconds: 750), curve: Curves.easeOut);
      },
    );
  }

  @override
  void dispose() {
    _onBoardingScroll.cancel();
    onBoardingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/picture/picture-background_top_middle.png',
              ),
            ),
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: onBoardingController,
                    pageSnapping: true,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: onBoardingData.length,
                    itemBuilder: (_, index) => KalmOnboardingContent(
                      imagePath: onBoardingData[index]['imagePath']!,
                      title: onBoardingData[index]['title']!,
                      subtitle: onBoardingData[index]['subtitle']!,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Spacer(flex: 1),
                        Container(
                          height: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              4,
                              (index) => buildOnboardingDot(index: index),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        KalmButton(
                          width: double.infinity,
                          height: 56,
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AuthPage(),
                              ),
                              (route) => false,
                            );
                          },
                          primaryColor: primaryColor,
                          child: Text(
                            'Selanjutnya',
                            style: kalmOfflineTheme.textTheme.button!
                                .apply(color: tertiaryColor),
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

  AnimatedContainer buildOnboardingDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 750),
      width: 22,
      height: 4,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: currentIndex == index ? primaryColor : Color(0xFFDEE3FC),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
