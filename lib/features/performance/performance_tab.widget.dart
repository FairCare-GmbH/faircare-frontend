import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class PerformanceTabItemWidget extends StatelessWidget {
  const PerformanceTabItemWidget({
    required this.value,
    required this.description,
    required this.isSelected,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final String value, description;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          decoration:
              BoxDecoration(boxShadow: isSelected ? [const BoxShadow()] : []),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: style(
                    color: FCColors.prime,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const VerticalSpacer(2),
                Text(
                  description,
                  style: style(
                    color: FCColors.darkGrey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
