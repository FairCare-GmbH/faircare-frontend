import 'package:faircare/features/users/register/register_progress.cubit.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPageProgressWidget extends StatelessWidget {
  const RegisterPageProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterProgressCubit, int>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 5,
              width: 60,
              color: FCColors.prime,
            ),
            Container(
              height: 5,
              width: 60,
              color: state == 1 ? FCColors.prime : FCColors.border,
            ),
          ],
        );
      },
    );
  }
}
