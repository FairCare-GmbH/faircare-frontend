import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/models/notification_model.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget(this.model, {Key? key}) : super(key: key);

  final NotificationModel model;

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
            decoration: const BoxDecoration(
              color: MyColors.prime,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '1x',
                style: style(
                  color: MyColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const HorizontalSpacer(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: style(
                    color: MyColors.prime,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const VerticalSpacer(2),
                Text(
                  model.subtitle,
                  style: style(
                    color: MyColors.darkGrey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const HorizontalSpacer(12),
          const Icon(
            Icons.delete,
            color: MyColors.darkGrey,
          ),
        ],
      ),
    );
  }
}
