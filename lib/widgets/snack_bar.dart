import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, {Color? bgColor, IconData? icon}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: bgColor ?? FCColors.prime,
        content: Row(
          children: [
            if (icon != null) Icon(icon, color: FCColors.white),
            if (icon != null) const HorizontalSpacer(12),
            Text(
              text,
              style: style(
                fontSize: 16,
                color: FCColors.white,
              ),
            ),
          ],
        ),
      ),
    );
}
