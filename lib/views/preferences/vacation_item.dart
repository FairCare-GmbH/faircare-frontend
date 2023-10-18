import 'package:faircare/global/colors.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class VacationItem extends StatelessWidget {
  const VacationItem(this.type, {Key? key}) : super(key: key);

  final VacationType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.border.withOpacity(0.3),
      ),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: getColor(),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                getIcon(),
                size: 20,
                color: MyColors.white,
              ),
            ),
          ),
          const HorizontalSpacer(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '27.10.2023',
                  style: style(
                    color: getColor(),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const VerticalSpacer(2),
                Text(
                  'Urlaub',
                  style: style(
                    color: MyColors.darkGrey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const HorizontalSpacer(12),
          Icon(
            getActionIcon(),
            color: getActionColor(),
          ),
        ],
      ),
    );
  }

  IconData getIcon() {
    switch (type) {
      case VacationType.old:
        return Icons.check;
      case VacationType.accepted:
        return Icons.check;
      case VacationType.pending:
        return Icons.cached;
    }
  }

  IconData getActionIcon() {
    switch (type) {
      case VacationType.old:
        return Icons.chevron_right;
      case VacationType.accepted:
        return Icons.delete;
      case VacationType.pending:
        return Icons.close;
    }
  }

  Color getColor() {
    switch (type) {
      case VacationType.old:
        return MyColors.grey;
      case VacationType.accepted:
        return MyColors.darkGrey;
      case VacationType.pending:
        return MyColors.red;
    }
  }

  Color getActionColor() {
    switch (type) {
      case VacationType.old:
        return MyColors.grey;
      case VacationType.accepted:
        return MyColors.darkGrey;
      case VacationType.pending:
        return MyColors.darkGrey;
    }
  }
}
