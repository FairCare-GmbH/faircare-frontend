import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/notifications/notification_item.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => pop(context),
            icon: const Icon(CupertinoIcons.back, size: 28),
          ),
          centerTitle: true,
          title: Text(
            'Updates',
            style: style(
              fontSize: 20,
              color: MyColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          separatorBuilder: (a, b) => const VerticalSpacer(12),
          itemCount: 3,
          itemBuilder: (context, index) {
            return const NotificationItem();
          },
        ),
      ),
    );
  }
}
