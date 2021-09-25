import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_button.dart';
import 'package:kalm/widgets/kalm_outlined_button.dart';
import 'package:kalm/widgets/kalm_text_button.dart';
import 'package:kalm/widgets/kalm_text_field.dart';

class Login extends StatefulWidget {
  final PageController pageController;
  Login({required this.pageController});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/picture/kalm-font-only-logo.png',
            scale: 1.8,
          ),
          SizedBox(height: 20),
          Text(
            'Masuk',
            style: kalmOfflineTheme.textTheme.subtitle2!
                .apply(color: tertiaryColor, fontSizeFactor: 1.5),
          ),
          SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Silahkan masuk menggunakan akun Kalm Anda',
              textAlign: TextAlign.center,
              style: kalmOfflineTheme.textTheme.subtitle2!
                  .apply(color: tertiaryColor, fontSizeFactor: 1.1),
            ),
          ),
          SizedBox(height: 24),
          KalmTextField(
            kalmTextFieldController: emailController,
            minLines: 1,
            maxLines: 1,
            hintText: 'Email/Username',
            keyboardType: TextInputType.emailAddress,
            focusColor: tertiaryColor.withOpacity(0.2),
            primaryColor: tertiaryColor.withOpacity(0.2),
            accentColor: tertiaryColor,
          ),
          SizedBox(height: 20),
          KalmTextField(
            kalmTextFieldController: passwordController,
            minLines: 1,
            maxLines: 1,
            hintText: 'Password',
            isObscure: true,
            keyboardType: TextInputType.visiblePassword,
            focusColor: tertiaryColor.withOpacity(0.2),
            primaryColor: tertiaryColor.withOpacity(0.2),
            accentColor: tertiaryColor,
            suffixIcon: Icons.visibility_outlined,
          ),
          SizedBox(height: 24),
          KalmButton(
            width: double.infinity,
            height: 56,
            borderRadius: 10,
            primaryColor: tertiaryColor,
            child: Text(
              'Login',
              style:
                  kalmOfflineTheme.textTheme.button!.apply(color: primaryColor),
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
          KalmTextButton(
            primaryColor: accentColor,
            width: double.infinity,
            height: 20,
            borderRadius: 10,
            onPressed: () {
              widget.pageController.animateToPage(
                2,
                duration: Duration(milliseconds: 750),
                curve: Curves.easeOut,
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
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: 1,
                decoration: BoxDecoration(
                  color: tertiaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                child: Text(
                  'Atau',
                  textAlign: TextAlign.center,
                  style: kalmOfflineTheme.textTheme.bodyText1!
                      .apply(color: tertiaryColor, fontSizeFactor: 1.2),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: 1,
                decoration: BoxDecoration(
                  color: tertiaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          KalmOutlinedButton(
            width: double.infinity,
            height: 56,
            primaryColor: tertiaryColor,
            borderRadius: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.email,
                  color: tertiaryColor,
                ),
                SizedBox(width: 8),
                Text(
                  'Login dengan Google',
                  style: kalmOfflineTheme.textTheme.button!
                      .apply(color: tertiaryColor),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
