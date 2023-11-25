import 'package:faircare/blocs/auth/progress/register_progress_cubit.dart';
import 'package:faircare/global/colors.dart';
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
              color: MyColors.prime,
            ),
            Container(
              height: 5,
              width: 60,
              color: state == 1 ? MyColors.prime : MyColors.border,
            ),
          ],
        );
      },
    );
  }
}
