import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';

class HorizontalTile extends StatelessWidget {
  final String text;
  final String mainText, secondaryText;
  final Color secondaryColor;
  final void Function()? onTap;

  const HorizontalTile(
    this.text, {
    required this.mainText,
    this.secondaryText = '',
    this.secondaryColor = FCColors.prime,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: style(fontSize: 16),
              ),
            ),
            Text(
              secondaryText,
              style: style(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: secondaryColor,
              ),
            ),
            Text(
              mainText,
              style: style(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: FCColors.prime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
