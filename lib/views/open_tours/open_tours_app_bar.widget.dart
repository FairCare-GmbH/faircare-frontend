import 'package:faircare/blocs/search/available_tours_search_cubit.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/user_dialog/user_image.dart';
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
                    const UserImage(),
                    const HorizontalSpacer(12),
                    Expanded(
                      child: Text(
                        'Offene Touren',
                        style: style(
                          color: MyColors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const NotificationButton(),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        context.read<AvailableToursSearchCubit>().showSearch();
                      },
                    )
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
              color: MyColors.border,
              thickness: 1,
            ),
          ],
        );
      },
    );
  }
}
