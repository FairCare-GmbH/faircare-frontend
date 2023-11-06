import 'package:faircare/global/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle style(
    {double fontSize = 14,
    Color color = MyColors.grey,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
    TextStyle? textStyle}) {
  return GoogleFonts.readexPro(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    textStyle: textStyle,
    height: height,
  );
}
