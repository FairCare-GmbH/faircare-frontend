import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';

class MyHeading extends StatelessWidget {
  const MyHeading(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style(
        fontSize: 18,
        color: MyColors.prime,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
