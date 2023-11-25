import 'package:faircare/features/users/user_bloc.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/features/ratings/small_circular_rating.widget.dart';
import 'package:faircare/features/users/user_settings/user_data.widget.dart';
import 'package:faircare/widgets/app_logo.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation/nav_bar.cubit.dart';
import '../../ratings/rating.dialog.dart';
import '../login.view.dart';

class UserSettingsDialog extends StatelessWidget {
  const UserSettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (BuildContext context, state) {
        if (state is UserDataLoaded) {
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        horizontalTitleGap: 0,
                        leading: SmallCircularRatingWidget(
                            rating: state.ratings.getAverageRating()),
                        onTap: () {
                          showRatingDialog(context);
                        },
                      ),

                      ListTile(
                        title: const Text('Meine Präferenzen'),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        horizontalTitleGap: 0,
                        leading: const Icon(Icons.settings,  color: MyColors.darkGrey),
                        onTap: () async {
                         pop(context);
                         BlocProvider.of<NavBarCubit>(context).setIndex(3);
                        },
                      ),

                      ListTile(
                        title: const Text('Passwort ändern'),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        horizontalTitleGap: 0,
                        leading:
                            const Icon(Icons.lock, color: MyColors.darkGrey),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Abmelden'),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        horizontalTitleGap: 0,
                        leading:
                            const Icon(Icons.logout, color: MyColors.darkGrey),
                        onTap: () {
                          navigateRemove(context, const LoginView());
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
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }
}

void showUserSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const UserSettingsDialog(),
      );
    },
  );
}
