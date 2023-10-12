import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeData = ThemeData(
  primarySwatch: Colors.blue,
  fontFamily: GoogleFonts.poppins().fontFamily,
  scaffoldBackgroundColor: MyColors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: MyColors.white,
    elevation: 0,
    titleSpacing: 12,
    titleTextStyle: style(
      color: MyColors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: const IconThemeData(color: MyColors.black),
  ),
);
