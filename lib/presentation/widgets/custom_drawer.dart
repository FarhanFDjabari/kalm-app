import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/cubit/auth/auth_cubit.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/styles/kalm_theme.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  CustomDrawer({required this.content});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _drawerController;
  final AuthCubit _authCubit = AuthCubit();

  Widget _buildDrawer() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: accentColor,
                      radius: 35,
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            state is AuthLoadSuccess
                                ? state.user.name!
                                : 'Andini Paramita',
                            overflow: TextOverflow.fade,
                            style: kalmOfflineTheme.textTheme.bodyText1!.apply(
                              color: tertiaryColor,
                              fontSizeFactor: 1.4,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Text(
                            state is AuthLoadSuccess
                                ? state.user.email!
                                : 'andini@gmail.com',
                            overflow: TextOverflow.fade,
                            style: kalmOfflineTheme.textTheme.bodyText1!.apply(
                              color: tertiaryColor,
                              fontSizeFactor: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Divider(
                  color: tertiaryColor,
                  endIndent: MediaQuery.of(context).size.width * 0.4,
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
                    _drawerController.reverse();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Iconsax.empty_wallet,
                    color: tertiaryColor,
                    size: 32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: Text(
                    'Langganan',
                    style: kalmOfflineTheme.textTheme.subtitle2!.apply(
                      color: tertiaryColor,
                      fontSizeFactor: 1.3,
                    ),
                  ),
                  onTap: () {
                    _drawerController.reverse();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Iconsax.star,
                    color: tertiaryColor,
                    size: 32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: Text(
                    'Nilai',
                    style: kalmOfflineTheme.textTheme.subtitle2!.apply(
                      color: tertiaryColor,
                      fontSizeFactor: 1.3,
                    ),
                  ),
                  onTap: () {
                    _drawerController.reverse();
                  },
                ),
                ListTile(
                  onTap: () {
                    _drawerController.reverse();
                  },
                  leading: Icon(
                    Icons.info_outline,
                    color: tertiaryColor,
                    size: 32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: Text(
                    'Bantuan',
                    style: kalmOfflineTheme.textTheme.subtitle2!.apply(
                      color: tertiaryColor,
                      fontSizeFactor: 1.3,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    _drawerController.reverse();
                    context.read<AuthCubit>().logout();
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
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (GetStorage().read('user_id') != null)
      _authCubit.getUserInfo(GetStorage().read('user_id'));
    _drawerController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _drawerController.dispose();
  }

  void onDrawerTap() => _drawerController.isDismissed
      ? _drawerController.forward()
      : _drawerController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDrawerTap,
      child: BlocProvider<AuthCubit>(
        create: (context) => _authCubit,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (authContext, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                KalmSnackbar(
                  message: state.errorMessage,
                  duration: Duration(seconds: 2),
                ),
              );
            }
            if (state is AuthDeleted) {
              Navigator.pushReplacementNamed(context, '/splash');
            }
          },
          builder: (builderContext, state) {
            return AnimatedBuilder(
              animation: _drawerController,
              builder: (context, child) {
                double slide = 300.0 * _drawerController.value;
                double scale = 1 - (_drawerController.value * 0.1);
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/picture/camera-bg-placeholder.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      _buildDrawer(),
                      Transform(
                        transform: Matrix4.identity()
                          ..translate(slide - 30)
                          ..scale(scale - 0.1),
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFE7EAFF),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Transform(
                        transform: Matrix4.identity()
                          ..translate(slide)
                          ..scale(scale),
                        alignment: Alignment.centerLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            _drawerController.value > 0 ? 15 : 0,
                          ),
                          child: widget.content,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
