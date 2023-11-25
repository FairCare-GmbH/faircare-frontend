import 'package:faircare/blocs/notifications/notifications/notifications_bloc.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_item.widget.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

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
        body: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsLoaded) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                separatorBuilder: (a, b) => const VerticalSpacer(10),
                itemCount: state.notifications.length,
                itemBuilder: (_, i) {
                  return NotificationItemWidget(state.notifications[i]);
                },
              );
            }
            return const LoadingIndicator();
          },
        ),
      ),
    );
  }
}
