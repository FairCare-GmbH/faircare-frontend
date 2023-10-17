import 'package:faircare/blocs/progress/register_progress_cubit.dart';
import 'package:faircare/views/register/account_creation_dialog.dart';
import 'package:faircare/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterNextButton extends StatelessWidget {
  const RegisterNextButton(this.controller, {Key? key}) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterProgressCubit, int>(
      builder: (context, state) {
        return Button(
          state == 1 ? 'Account erstellen' : 'Weiter',
          onPressed: () {
            if (state == 1) {
              showAccountCreationDialog(context);
            } else {
              controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
        );
      },
    );
  }
}
