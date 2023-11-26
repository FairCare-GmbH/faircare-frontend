import 'package:faircare/features/users/user_settings/user_profile_image.widget.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/notification_button.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class OpenToursAppBar extends StatelessWidget {
  const OpenToursAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // app bar content
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            children: [
              const UserProfileImageWidget(),
              const HorizontalSpacer(12),
              Expanded(
                child: Text(
                  'Offene Touren',
                  style: style(
                    color: FCColors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const NotificationButton(),
              // IconButton(
              //   icon: const Icon(Icons.search),
              //   onPressed: () {
              //     context.read<AvailableToursSearchCubit>().showSearch();
              //   },
              // )
            ],
          ),
        ),

        // search text field
        // SearchField(
        //   TextEditingController(),
        //   onCloseTap: () {
        //     context.read<AvailableToursSearchCubit>().hideSearch();
        //   },
        // ),

        // divider
        const Divider(
          height: 8,
          color: FCColors.border,
          thickness: 1,
        ),
      ],
    );
  }
}
