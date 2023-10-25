import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/models/vacation_model.dart';
import 'package:faircare/views/preferences/dialogs/cancel_vacation_dialog.dart';
import 'package:faircare/views/preferences/dialogs/give_back_vacation_dialog.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VacationItem extends StatelessWidget {
  const VacationItem(this.model, {Key? key}) : super(key: key);

  final VacationModel model;

  @override
  Widget build(BuildContext context) {
    bool before = model.fromDate.isBefore(DateTime.now());

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
              color: getColor(before),
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
                  '${DateFormat('dd.MM.yyyy').format(model.fromDate)}'
                  '${!model.fromDate.isAtSameMomentAs(model.toDate) ? ''
                      ' - ${DateFormat('dd.MM.yyyy').format(model.toDate)}'
                      '' : ''}',
                  style: style(
                    color: getColor(before),
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
          InkWell(
            onTap: () => getAction(context, before),
            child: Icon(
              getActionIcon(before),
              color: getActionColor(before),
            ),
          ),
        ],
      ),
    );
  }

  void getAction(BuildContext context, bool before) {
    if (model.approvalStatus == 1) {
      if (before) return;
      return showGiveBackVacationDialog(context);
    }
    return showCancelVacationDialog(context);
  }

  IconData getIcon() {
    if (model.approvalStatus == 1) return Icons.check;
    return Icons.cached;
  }

  IconData getActionIcon(bool before) {
    if (model.approvalStatus == 1) {
      if (before) return Icons.chevron_right;
      return Icons.delete;
    }
    return Icons.close;
  }

  Color getColor(bool before) {
    if (model.approvalStatus == 1) {
      if (before) return MyColors.grey;
      return MyColors.darkGrey;
    }
    return MyColors.red;
  }

  Color getActionColor(bool before) {
    if (model.approvalStatus == 1) {
      if (before) return MyColors.grey;
      return MyColors.darkGrey;
    }
    return MyColors.darkGrey;
  }
}
