import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/global.dart';
import 'package:flutter/material.dart';

import '../features/notifications/notifications.view.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              navigate(context, const NotificationsView());
            },
          ),
        ),
        const Positioned(
          right: 14,
          top: 11,
          child: Center(
            child: CircleAvatar(
              radius: 3,
              backgroundColor: FCColors.prime,
            ),
          ),
        ),
      ],
    );
  }
}
