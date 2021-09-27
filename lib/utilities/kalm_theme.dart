import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kalmTheme = ThemeData(
  primaryColor: primaryColor,
  fontFamily: 'Montserrat',
  textTheme: TextTheme(
    headline1: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    headline2: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
    ),
    subtitle1: GoogleFonts.montserrat(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    button: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    bodyText1: GoogleFonts.montserrat(),
    caption: GoogleFonts.montserrat(),
  ),
);
ThemeData kalmOfflineTheme = ThemeData(
  primaryColor: primaryColor,
  accentColor: accentColor,
  backgroundColor: backgroundColor,
  fontFamily: 'Montserrat',
  textTheme: TextTheme(
    headline1: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    headline4: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    headline5: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    subtitle1: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
    button: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    bodyText1: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    bodyText2: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 13,
      fontWeight: FontWeight.w600,
    ),
    overline: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 10,
      fontWeight: FontWeight.w600,
    ),
    caption: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
  ),
);

const primaryColor = Color(0xFF8C97DC);
const accentColor = Color(0xFFEFF1FD);
const backgroundColor = Color(0xFFF8F8F8);
const tertiaryColor = Colors.white;
const primaryText = Color(0xFF303C57);
const secondaryText = Color(0xFF969CA8);
const tertiaryText = Color(0xFFE7E7E7);

final splashBg = LinearGradient(
  colors: [
    Color(0xFFCED5FF),
    Color(0xFF7E8EF5),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
