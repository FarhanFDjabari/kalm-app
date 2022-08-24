import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalm/presentation/cubit/auth/auth_cubit.dart';
import 'package:kalm/presentation/views/curhat/curhat_home.dart';
import 'package:kalm/presentation/views/home/home_page.dart';
import 'package:kalm/presentation/views/journey/journey_page.dart';
import 'package:kalm/presentation/views/meditation/meditation_page.dart';
import 'package:kalm/presentation/views/mood_tracker/mood_tracker_page.dart';
import 'package:kalm/presentation/widgets/kalm_dialog.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/styles/kalm_theme.dart';
import 'package:kalm/utilities/routes/route_name.dart';

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
      drawer: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthDeleted) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.AUTH, (route) => false);
          }
        },
        builder: (builderContext, state) {
          return Drawer(
            shape: RoundedRectangleBorder(),
            elevation: 1,
            backgroundColor: primaryColor,
            child: Column(
              children: [
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: accentColor,
                        radius: 35,
                      ),
                      SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              state is AuthLoadSuccess
                                  ? state.user.name!
                                  : 'Andini Paramita',
                              overflow: TextOverflow.fade,
                              style:
                                  kalmOfflineTheme.textTheme.bodyText1!.apply(
                                color: tertiaryColor,
                                fontSizeFactor: 1.4,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Text(
                              state is AuthLoadSuccess
                                  ? state.user.email!
                                  : 'andini@gmail.com',
                              overflow: TextOverflow.fade,
                              style:
                                  kalmOfflineTheme.textTheme.bodyText1!.apply(
                                color: tertiaryColor,
                                fontSizeFactor: 1.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: tertiaryColor,
                  thickness: 0.5,
                ),
                SizedBox(height: 15),
                ListTile(
                  leading: Icon(
                    Iconsax.user,
                    color: tertiaryColor,
                    size: 32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: Text(
                    'Profil',
                    style: kalmOfflineTheme.textTheme.subtitle2!.apply(
                      color: tertiaryColor,
                      fontSizeFactor: 1.3,
                    ),
                  ),
                  onTap: () {
                    // _drawerController.reverse();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    builderContext.read<AuthCubit>().logout();
                  },
                  leading: Icon(
                    Iconsax.logout,
                    color: tertiaryColor,
                    size: 32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: Text(
                    'Logout',
                    style: kalmOfflineTheme.textTheme.subtitle2!.apply(
                      color: tertiaryColor,
                      fontSizeFactor: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
              Iconsax.home_25,
            ),
            label: 'Beranda',
            tooltip: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.graph5,
              size: 28,
            ),
            label: 'Tracker',
            tooltip: 'Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.message_notif5,
            ),
            label: 'Curhat',
            tooltip: 'Curhat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.music5,
            ),
            label: 'Meditasi',
            tooltip: 'Meditasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.flag5,
            ),
            label: 'Journey',
            tooltip: 'Journey',
          ),
        ],
        backgroundColor: tertiaryColor,
        showUnselectedLabels: true,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryText.withOpacity(0.75),
        currentIndex: _selectedIndex,
        elevation: 0,
      ),
    );
  }
}
