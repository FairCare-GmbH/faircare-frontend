import 'package:faircare/features/users/user_settings/user_settings.dialog.dart';
import 'package:flutter/material.dart';

class UserProfileImageWidget extends StatelessWidget {
  const UserProfileImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showUserSettingsDialog(context);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: const Icon(Icons.person, size: 36),
        // child: CachedNetworkImage(
        //   imageUrl: 'https://thispersondoesnotexist.com/',
        //   width: 36,
        // ),
      ),
    );
  }
}
