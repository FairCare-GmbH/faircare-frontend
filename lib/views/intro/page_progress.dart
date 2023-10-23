import 'package:faircare/blocs/intro/progress/intro_progress_cubit.dart';
import 'package:faircare/global/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroPageProgress extends StatelessWidget {
  const IntroPageProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntroProgressCubit, int>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 5,
              width: 30,
              color: MyColors.prime,
            ),
            Container(
              height: 5,
              width: 30,
              color: state >= 1 ? MyColors.prime : MyColors.border,
            ),
            Container(
              height: 5,
              width: 30,
              color: state >= 2 ? MyColors.prime : MyColors.border,
            ),
            Container(
              height: 5,
              width: 30,
              color: state >= 3 ? MyColors.prime : MyColors.border,
            ),
          ],
        );
      },
    );
  }
}
