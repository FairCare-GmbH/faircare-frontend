import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton(
    this.text, {
    this.color = FCColors.prime,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final String text;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: style(fontSize: 14, color: color),
        ),
      ),
    );
  }
}
