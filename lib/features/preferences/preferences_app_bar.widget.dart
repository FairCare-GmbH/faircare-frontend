import 'package:dio/dio.dart';
import 'package:faircare/api/api_exception.dart';
import 'package:faircare/features/preferences/state/preferences.bloc.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/notification_button.dart';
import 'package:faircare/widgets/snack_bar.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import '../users/user_settings/user_profile_image.widget.dart';

class PreferencesAppBarWidget extends StatelessWidget {
  const PreferencesAppBarWidget({Key? key}) : super(key: key);

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
                  'Präferenzen',
                  style: style(
                    color: FCColors.black,
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
          color: FCColors.border,
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
        final state = BlocProvider.of<PreferencesBloc>(context).state;
        if (state is PreferenceLoaded) {
          Api.request('/preferences', options: Options(method: 'POST'), data: {
            'nurse': state.userModel.toJson(),
            'preferences': state.preferences.map((e) => e.toJson()).toList()
          })
              .then((value) => showSnackBar(
                    context,
                    'Präferenzen gespeichert',
                    icon: Icons.save,
                  ))
              .onError((error, stackTrace) {
            if (error is ApiException) error.showDialog(context);
          });
        }
      },
    );
  }
}
