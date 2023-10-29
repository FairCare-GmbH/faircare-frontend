import 'package:faircare/api/api.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/views/login/login.dart';
import 'package:faircare/views/rating_dialog/rating_dialog.dart';
import 'package:faircare/views/user_dialog/small_circular_rating.dart';
import 'package:faircare/views/user_dialog/user_data_widget.dart';
import 'package:faircare/widgets/app_logo.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:flutter/material.dart';

class UserDialog extends StatelessWidget {
  const UserDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // logo and close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.close, color: Colors.transparent),
                    const AppLogo(size: 24),
                    InkWell(
                      onTap: () => pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const VerticalSpacer(32),

                // user data
                const UserDataWidget(),
                const VerticalSpacer(32),

                // options
                ListTile(
                  title: const Text('Meine Bewertungen'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  horizontalTitleGap: 0,
                  leading: SmallCircularRating(
                      rating: Api.getUser()?.getAverageRating()),
                  onTap: () {
                    showRatingDialog(context);
                  },
                ),
                ListTile(
                  title: const Text('Passwort ändern'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  horizontalTitleGap: 0,
                  leading: const Icon(Icons.lock, color: MyColors.darkGrey),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Abmelden'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  horizontalTitleGap: 0,
                  leading: const Icon(Icons.logout, color: MyColors.darkGrey),
                  onTap: () {
                    navigateRemove(context, const LoginPage());
                  },
                ),
              ],
            ),
          ),
          const VerticalSpacer(8),
          const Divider(),
          const VerticalSpacer(8),

          // buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyTextButton(
                  'Datenschutz',
                  onTap: () {},
                ),
                MyTextButton(
                  'Nutzungsbedingungen',
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void showUserDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const UserDialog(),
      );
    },
  );
}
