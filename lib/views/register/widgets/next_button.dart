import 'package:faircare/blocs/auth/register_cubit/register_cubit.dart';
import 'package:faircare/blocs/progress/register_progress_cubit.dart';
import 'package:faircare/models/register_model.dart';
import 'package:faircare/views/register/dialogs/account_creation_dialog.dart';
import 'package:faircare/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterNextButton extends StatelessWidget {
  const RegisterNextButton(this.controller, {Key? key}) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterModel>(
      builder: (context, state) {
        return BlocBuilder<RegisterProgressCubit, int>(
          builder: (context, progressState) {
            return Button(
              progressState == 1 ? 'Account erstellen' : 'Weiter',
              disabled: progressState == 1 &&
                  (!state.termsAgreed || !state.dataProtectionAgreed),
              onPressed: () {
                if (progressState == 0) {
                  if (true) {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                } else if (progressState == 1) {
                  if (state.termsAgreed && state.dataProtectionAgreed) {
                    showAccountCreationDialog(context);
                  }
                }
              },
            );
          },
        );
      },
    );
  }
}
