import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kalm/presentation/widgets/kalm_button.dart';
import 'package:kalm/presentation/widgets/kalm_outlined_button.dart';
import 'package:kalm/presentation/widgets/kalm_text_button.dart';
import 'package:kalm/styles/kalm_theme.dart';

class AuthWelcome extends StatelessWidget {
  const AuthWelcome({
    Key? key,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/picture/picture-moodtracker_baik.png',
            scale: 2,
          ),
          SizedBox(height: 20),
          Image.asset(
            'assets/picture/kalm-font-only-logo.png',
            scale: 1.7,
          ),
          SizedBox(height: 20),
          Text(
            'Selamat Datang',
            style: kalmOfflineTheme.textTheme.subtitle2!
                .apply(color: tertiaryColor, fontSizeFactor: 1.5),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          KalmOutlinedButton(
            width: double.infinity,
            height: 54,
            primaryColor: tertiaryColor,
            borderRadius: 10,
            child: Text(
              'Login dengan Email',
              style: kalmOfflineTheme.textTheme.button!
                  .apply(color: tertiaryColor),
            ),
            onPressed: () {
              _pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 750),
                curve: Curves.easeOut,
              );
            },
          ),
          SizedBox(height: 24),
          KalmButton(
            width: double.infinity,
            height: 54,
            primaryColor: tertiaryColor,
            borderRadius: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icon/Google.svg',
                ),
                SizedBox(width: 8),
                Text(
                  'Login dengan Google',
                  style: kalmOfflineTheme.textTheme.button!
                      .apply(color: primaryColor),
                ),
              ],
            ),
            onPressed: () {},
          ),
          SizedBox(height: 24),
          KalmTextButton(
            primaryColor: accentColor,
            width: double.infinity,
            height: 20,
            borderRadius: 10,
            onPressed: () {
              _pageController.animateToPage(
                2,
                duration: Duration(milliseconds: 750),
                curve: Curves.easeInOut,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Belum punya akun? ',
                  style: kalmOfflineTheme.textTheme.subtitle1!.apply(
                    color: tertiaryColor.withOpacity(0.8),
                    fontSizeFactor: 1.2,
                  ),
                ),
                Text(
                  'Daftar',
                  style: kalmOfflineTheme.textTheme.subtitle1!.apply(
                    color: tertiaryColor,
                    fontSizeFactor: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
