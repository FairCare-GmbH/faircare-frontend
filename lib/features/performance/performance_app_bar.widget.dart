import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/notification_button.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

import '../users/user_settings/user_profile_image.widget.dart';

class PerformanceAppBarWidget extends StatelessWidget {
  const PerformanceAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const UserProfileImageWidget(),
              const HorizontalSpacer(12),
              Expanded(
                child: Text(
                  'Meine Umsätze',
                  style: style(
                    color: FCColors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const NotificationButton(),
            ],
          ),
        ),

        // divider
        const Divider(
          height: 8,
          color: FCColors.border,
          thickness: 1,
        ),
      ],
    );
  }
}
