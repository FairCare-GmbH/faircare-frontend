import 'package:faircare/features/getting_started/getting_started_progress_cubit.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GettingStartedPageProgress extends StatelessWidget {
  const GettingStartedPageProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GettingStartedProgressCubit, int>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 5,
              width: 30,
              color: FCColors.prime,
            ),
            Container(
              height: 5,
              width: 30,
              color: state >= 1 ? FCColors.prime : FCColors.border,
            ),
            Container(
              height: 5,
              width: 30,
              color: state >= 2 ? FCColors.prime : FCColors.border,
            ),
            Container(
              height: 5,
              width: 30,
              color: state >= 3 ? FCColors.prime : FCColors.border,
            ),
          ],
        );
      },
    );
  }
}
