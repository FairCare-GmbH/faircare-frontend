import 'package:faircare/global/fc_colors.dart';
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
        color: FCColors.prime,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class Subheading extends StatelessWidget {
  const Subheading(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style(fontSize: 16, color: FCColors.darkGrey),
    );
  }
}
