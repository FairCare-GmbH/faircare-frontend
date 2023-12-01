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
            SizedBox(
              width: 120,
              child: Text(
                text,
                style: style(fontSize: 16),
              ),
            ),
            if (secondaryText.isNotEmpty)
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    secondaryText,
                    overflow: TextOverflow.ellipsis,
                    style: style(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),
            if (secondaryText.isNotEmpty)
            Text(
              mainText,
              overflow: TextOverflow.ellipsis,
              style: style(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: FCColors.prime,
              ),
            ),
            if (secondaryText.isEmpty)
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    mainText,
                    overflow: TextOverflow.ellipsis,
                    style: style(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: FCColors.prime,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
