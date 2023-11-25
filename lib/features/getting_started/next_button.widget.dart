import 'package:faircare/features/getting_started/getting_started_progress_cubit.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/features/users/login.view.dart';
import 'package:faircare/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GettingStartedNextButtonWidget extends StatelessWidget {
  const GettingStartedNextButtonWidget(this.controller, {Key? key}) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GettingStartedProgressCubit, int>(
      builder: (context, state) {
        return Button(
          state == 3 ? 'Los geht’s' : 'Weiter',
          onPressed: () {
            if (state == 3) {
              navigateRemove(context, const LoginView());
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
