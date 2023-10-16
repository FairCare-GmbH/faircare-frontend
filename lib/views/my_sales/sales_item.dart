import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class SalesItem extends StatelessWidget {
  const SalesItem({
    required this.icon,
    required this.title,
    required this.count,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String title, count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.primeLightest,
      ),
      child: Row(
        children: [
          Icon(icon, color: MyColors.prime, size: 36),
          const HorizontalSpacer(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: style(
                  color: MyColors.darkGrey,
                  fontSize: 13,
                ),
              ),
              const VerticalSpacer(2),
              Text(
                count,
                style: style(
                  color: MyColors.prime,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
