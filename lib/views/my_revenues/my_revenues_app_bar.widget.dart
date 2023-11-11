import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/user_dialog/user_image.dart';
import 'package:faircare/widgets/notification_button.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class MyRevenuesAppBarWidget extends StatelessWidget {
  const MyRevenuesAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const UserImage(),
              const HorizontalSpacer(12),
              Expanded(
                child: Text(
                  'Meine Umsätze',
                  style: style(
                    color: MyColors.black,
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
          color: MyColors.border,
          thickness: 1,
        ),
      ],
    );
  }
}
