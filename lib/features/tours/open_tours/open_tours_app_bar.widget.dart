import 'package:faircare/features/tours/open_tours/open_tours_search.cubit.dart';
import 'package:faircare/features/users/user_settings/user_profile_image.widget.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/notification_button.dart';
import 'package:faircare/widgets/search_field.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenToursAppBar extends StatelessWidget {
  const OpenToursAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailableToursSearchCubit, SearchState>(
      builder: (context, state) {
        return Column(
          children: [
            // app bar content
            if (state == SearchState.none)
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
            if (state == SearchState.search)
              SearchField(
                TextEditingController(),
                onCloseTap: () {
                  context.read<AvailableToursSearchCubit>().hideSearch();
                },
              ),

            // divider
            const Divider(
              height: 8,
              color: FCColors.border,
              thickness: 1,
            ),
          ],
        );
      },
    );
  }
}
