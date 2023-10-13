import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final int index;

  const BottomNavItem({
    required this.text,
    required this.icon,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          // update index
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: index == 0 ? MyColors.prime : MyColors.darkGrey,
            ),
            const VerticalSpacer(4),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: style(
                fontSize: 12,
                color: index == 0 ? MyColors.prime : MyColors.darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
