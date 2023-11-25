import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class MyFilterChip extends StatelessWidget {
  const MyFilterChip(
    this.text, {
    this.selected = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final String text;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selected ? FCColors.primeLight : FCColors.primeLightest,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selected) const Icon(Icons.check),
            if (selected) const HorizontalSpacer(8),
            Text(
              text,
              style: style(
                color: FCColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
