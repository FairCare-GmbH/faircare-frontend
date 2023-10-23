import 'package:faircare/blocs/intro/progress/intro_progress_cubit.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/views/login/login.dart';
import 'package:faircare/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroNextButton extends StatelessWidget {
  const IntroNextButton(this.controller, {Key? key}) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntroProgressCubit, int>(
      builder: (context, state) {
        return Button(
          state == 3 ? 'Los geht’s' : 'Weiter',
          onPressed: () {
            if (state == 3) {
              navigateRemove(context, const LoginPage());
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
