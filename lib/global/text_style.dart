import 'package:faircare/global/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle style({
  double fontSize = 14,
  Color color = MyColors.black,
  FontWeight fontWeight = FontWeight.w400,
  double height = 1.2,
}) {
  return GoogleFonts.poppins(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    height: height,
  );
}
