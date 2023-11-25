import 'package:faircare/api/api.dart';
import 'package:faircare/features/users/register/register_progress.cubit.dart';
import 'package:faircare/features/users/register/register_cubit.dart';
import 'package:faircare/features/users/register/register.model.dart';
import 'package:faircare/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../api/api_exception.dart';
import '../dialogs/account_creation_dialog.dart';

class RegisterNextButtonWidget extends StatelessWidget {
  const RegisterNextButtonWidget(this.controller, {Key? key}) : super(key: key);

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
                    Api.register(state.copyWith(password: state.phone)).then((user) {//TODO allow user to specify own password in the future (not for beta)
                      showAccountCreationDialog(context);
                    }, onError: (error) {
                      if (error is ApiException) {
                        error.showDialog(context);
                      }
                    });
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
