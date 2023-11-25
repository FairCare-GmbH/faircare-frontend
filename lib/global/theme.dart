import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeData = ThemeData(
  primarySwatch: Colors.blue,
  fontFamily: GoogleFonts.readexPro().fontFamily,
  scaffoldBackgroundColor: FCColors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: FCColors.white,
    elevation: 0,
    titleSpacing: 12,
    titleTextStyle: style(
      color: FCColors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: const IconThemeData(color: FCColors.black),
  ),
);
