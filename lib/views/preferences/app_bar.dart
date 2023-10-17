import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/user_dialog/user_image.dart';
import 'package:faircare/widgets/notification_button.dart';
import 'package:faircare/widgets/snack_bar.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class PreferencesAppBar extends StatelessWidget {
  const PreferencesAppBar({Key? key}) : super(key: key);

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
                  'Präferenzen',
                  style: style(
                    color: MyColors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const NotificationButton(),
              const SaveButton(),
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

class SaveButton extends StatelessWidget {
  const SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.save),
      onPressed: () {
        showSnackBar(
          context,
          'Präferenzen gespeichert',
          icon: Icons.save,
        );
      },
    );
  }
}
