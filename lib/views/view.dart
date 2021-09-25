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
      bottomNavigationBar: Container(
        child: Row(
          children: [
            _buildNavigationItem(icon: Iconsax.home5, itemCount: 5, index: 0),
            _buildNavigationItem(icon: Iconsax.graph5, itemCount: 5, index: 1),
            _buildNavigationItem(
                icon: Iconsax.message5, itemCount: 5, index: 2),
            _buildNavigationItem(icon: Iconsax.music5, itemCount: 5, index: 3),
            _buildNavigationItem(icon: Iconsax.flag5, itemCount: 5, index: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required int itemCount,
    required int index,
    Color color = primaryColor,
  }) {
    return InkWell(
      onTap: () {
        _pageController.jumpToPage(index);
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / itemCount,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Icon(
                  icon,
                  size: 28,
                  color: index == _selectedIndex ? primaryColor : secondaryText,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 350),
              width: 28,
              height: index == _selectedIndex ? 6 : 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
