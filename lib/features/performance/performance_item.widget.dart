import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class PerformanceItemWidget extends StatelessWidget {
  const PerformanceItemWidget({
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
        color: FCColors.primeLightest,
      ),
      child: Row(
        children: [
          Icon(icon, color: FCColors.prime, size: 36),
          const HorizontalSpacer(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: style(
                  color: FCColors.darkGrey,
                  fontSize: 13,
                ),
              ),
              const VerticalSpacer(2),
              Text(
                count,
                style: style(
                  color: FCColors.prime,
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
