import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class CheckboxTile extends StatelessWidget {
  const CheckboxTile(
    this.value, {
    this.textSecondary,
    required this.textMain,
    this.onTap,
    this.onTextTap,
    Key? key,
  }) : super(key: key);

  final bool value;
  final String? textSecondary;
  final String textMain;
  final VoidCallback? onTap;
  final VoidCallback? onTextTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 18,
            width: 18,
            // padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: value ? MyColors.prime : Colors.transparent,
              border: Border.all(color: MyColors.prime),
            ),
            child: Icon(
              Icons.check,
              color: value ? MyColors.white : Colors.transparent,
              size: 16,
            ),
          ),
        ),
        const HorizontalSpacer(6),
        if (textSecondary != null)
          InkWell(
            onTap: onTextTap,
            child: Text(
              textSecondary!,
              style: style(color: MyColors.prime),
            ),
          ),
        Text(
          textMain,
          style: style(color: MyColors.darkGrey),
        ),
      ],
    );
  }
}
