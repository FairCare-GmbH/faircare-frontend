import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton(this.text, {this.onTap, Key? key}) : super(key: key);

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: style(
          fontSize: 14,
          color: MyColors.prime,
        ),
      ),
    );
  }
}
