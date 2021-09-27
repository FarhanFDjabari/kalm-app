import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_animation_container.dart';

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

    _animationController.forward().then(
          (value) => Timer(
            Duration(seconds: 3),
            () => Navigator.pushNamedAndRemoveUntil(
                context, '/onboarding', (route) => false),
          ),
        );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
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
