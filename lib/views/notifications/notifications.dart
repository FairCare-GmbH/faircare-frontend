import 'package:faircare/global/colors.dart';
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
          leading: const Icon(CupertinoIcons.back),
          centerTitle: true,
          title: Text(
            'Notifications',
            style: style(fontSize: 18, color: MyColors.black),
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
