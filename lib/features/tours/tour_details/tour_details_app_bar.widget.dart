import 'package:faircare/features/users/user_settings/user_profile_image.widget.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class ToursDetailsAppBarWidget extends StatelessWidget {
  const ToursDetailsAppBarWidget({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const UserProfileImageWidget(),
              const HorizontalSpacer(12),
              Expanded(
                child: Text(
                  title,
                  style: style(
                    color: FCColors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => pop(context),
              )
            ],
          ),
        ),
        const Divider(height: 8),
      ],
    );
  }
}
