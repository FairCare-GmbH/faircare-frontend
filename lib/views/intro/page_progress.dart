import 'package:faircare/global/colors.dart';
import 'package:flutter/material.dart';

class IntroPageProgress extends StatelessWidget {
  const IntroPageProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          color: MyColors.border,
        ),
        Container(
          height: 5,
          width: 30,
          color: MyColors.border,
        ),
        Container(
          height: 5,
          width: 30,
          color: MyColors.border,
        ),
      ],
    );
  }
}
