import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class HorizontalTile extends StatelessWidget {
  final String text, selectedText;
  final IconData? icon;
  final void Function()? onTap;

  const HorizontalTile(
    this.text, {
    this.icon,
    this.selectedText = '',
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Row(
          children: [
            if (icon != null) Icon(icon, size: 24),
            if (icon != null) const HorizontalSpacer(12),
            Text(
              text,
              style: style(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Text(
              selectedText,
              style: style(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const HorizontalSpacer(6),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
