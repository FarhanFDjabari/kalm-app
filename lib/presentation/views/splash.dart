import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/widgets/kalm_animation_container.dart';
import 'package:kalm/presentation/widgets/kalm_dialog.dart';
import 'package:kalm/styles/kalm_theme.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 750,
      ),
    );

    _animationController.forward();
    checkInternetConnection();
  }

  checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
        type: InternetAddressType.IPv4,
      );
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (await GetStorage().read('user_id') == null)
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/onboarding',
            (route) => false,
          );
        else
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/',
            (route) => false,
          );
      }
    } on SocketException catch (_) {
      showDialog(
        context: context,
        builder: (context) => KalmDialog(
          title: 'Perangkat kamu tidak terkoneksi dengan internet',
          subtitle:
              'Kamu membutuhkan koneksi internet agar dapat menggunakan fitur aplikasi',
          successButtonTitle: 'Oke',
          onSuccess: () async {
            await AppSettings.openDeviceSettings(
              asAnotherTask: true,
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: splashBg,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: KalmAnimationContainer(
                animationController: _animationController,
                begin: Offset(0, -1),
                end: Offset.zero,
                child: Image.asset(
                  'assets/picture/picture-background_top_left.png',
                  scale: 2,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: KalmAnimationContainer(
                animationController: _animationController,
                begin: Offset(0, 1),
                end: Offset.zero,
                child: Image.asset(
                  'assets/picture/picture-background_bottom_right.png',
                  scale: 2,
                ),
              ),
            ),
            Positioned.fill(
              top: 1,
              bottom: 1,
              left: 1,
              right: 1,
              child: FadeTransition(
                opacity: _animationController,
                child: Image.asset(
                  'assets/picture/kalm-font-logo.png',
                  scale: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
