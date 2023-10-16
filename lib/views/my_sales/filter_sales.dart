import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilterItem(
            'Akueller Monat',
            Icons.date_range,
            selected: true,
            onTap: () {},
          ),
          FilterItem(
            'Alle Touren',
            Icons.calendar_today,
            onTap: () {},
          ),
        ],
      );
    },
  );
}

class FilterItem extends StatelessWidget {
  const FilterItem(
    this.text,
    this.icon, {
    this.selected = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? MyColors.prime : MyColors.darkGrey,
            ),
            const HorizontalSpacer(16),
            Expanded(
              child: Text(
                text,
                style: style(
                  fontSize: 16,
                  color: selected ? MyColors.prime : MyColors.darkGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
