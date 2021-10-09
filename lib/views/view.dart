import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/views/curhat/curhat_home.dart';
import 'package:kalm/views/home/home_page.dart';
import 'package:kalm/views/journey/journey_page.dart';
import 'package:kalm/views/meditation/meditation_page.dart';
import 'package:kalm/views/mood_tracker/mood_tracker_page.dart';
import 'package:kalm/widgets/kalm_dialog.dart';

class View extends StatefulWidget {
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final pages = [
    HomePage(),
    MoodTrackerPage(),
    CurhatHome(),
    MeditationPage(),
    JourneyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: WillPopScope(
        onWillPop: () async {
          final bool shouldPop = await showDialog(
              context: context,
              builder: (context) => KalmDialog(
                    onSuccess: () => Navigator.of(context).pop(true),
                    onCancel: () => Navigator.of(context).pop(false),
                    title: 'Apakah kamu yakin?',
                    successButtonTitle: 'Keluar',
                    cancelButtonTitle: 'Batal',
                  ));

          return shouldPop;
        },
        child: PageView(
          children: pages,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _pageController.jumpToPage(index),
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.home5,
            ),
            label: 'Beranda',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.graph5,
            ),
            label: 'Tracker',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.message5,
            ),
            label: 'Curhat',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.music5,
            ),
            label: 'Meditasi',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.flag5,
            ),
            label: 'Journey',
            tooltip: '',
          ),
        ],
        backgroundColor: tertiaryColor,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryText.withOpacity(0.75),
        currentIndex: _selectedIndex,
        elevation: 1,
      ),
    );
  }
}
