import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';

class CalendarWeekDay extends StatelessWidget {
  const CalendarWeekDay(this.text, {this.color, Key? key}) : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: style(
              color: color == null ? MyColors.darkGrey : MyColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
