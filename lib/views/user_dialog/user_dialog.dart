import 'package:cached_network_image/cached_network_image.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/login/login.dart';
import 'package:faircare/views/rating_dialog/rating_dialog.dart';
import 'package:faircare/views/user_dialog/small_circular_rating.dart';
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
                Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: CachedNetworkImage(
                            imageUrl: 'https://thispersondoesnotexist.com/',
                            width: 48,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: -4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: MyColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: MyColors.black.withOpacity(0.1),
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.photo_camera,
                              size: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                    const HorizontalSpacer(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Max Mustermann',
                            style: style(
                              fontSize: 18,
                              color: MyColors.black,
                            ),
                          ),
                          Text(
                            'mustermann@getfaircare.de',
                            style: style(
                              color: MyColors.darkGrey,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const VerticalSpacer(32),

                // options
                ListTile(
                  title: const Text('Meine Bewertungen'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  horizontalTitleGap: 0,
                  leading: const SmallCircularRating(rating: 3.4),
                  onTap: () {
                    pop(context);
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
                  'Datenschutzerklärung',
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
