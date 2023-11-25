import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/features/notifications/notification.model.dart';
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
        color: FCColors.border.withOpacity(0.3),
      ),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: const BoxDecoration(
              color: FCColors.prime,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '1x',
                style: style(
                  color: FCColors.white,
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
                    color: FCColors.prime,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const VerticalSpacer(2),
                Text(
                  model.subtitle,
                  style: style(
                    color: FCColors.darkGrey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const HorizontalSpacer(12),
          const Icon(
            Icons.delete,
            color: FCColors.darkGrey,
          ),
        ],
      ),
    );
  }
}
