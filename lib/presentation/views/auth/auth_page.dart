import 'package:flutter/material.dart';
import 'package:kalm/presentation/views/auth/login.dart';
import 'package:kalm/presentation/views/auth/register.dart';
import 'package:kalm/presentation/widgets/kalm_animation_container.dart';
import 'package:kalm/styles/kalm_theme.dart';

import 'auth_welcome.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final PageController _pageController = PageController(initialPage: 0);

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
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            FadeTransition(
              opacity: _animationController,
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                pageSnapping: true,
                children: [
                  AuthWelcome(
                    pageController: _pageController,
                  ),
                  Login(
                    pageController: _pageController,
                  ),
                  Register(
                    pageController: _pageController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
