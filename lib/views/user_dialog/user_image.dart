import 'package:cached_network_image/cached_network_image.dart';
import 'package:faircare/views/user_dialog/user_dialog.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showUserDialog(context);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: CachedNetworkImage(
          imageUrl: 'https://thispersondoesnotexist.com/',
          width: 36,
        ),
      ),
    );
  }
}