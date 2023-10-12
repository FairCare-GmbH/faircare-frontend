import 'package:faircare/global/colors.dart';
import 'package:flutter/material.dart';

class RegisterPageProgress extends StatelessWidget {
  const RegisterPageProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          color: MyColors.border,
        ),
      ],
    );
  }
}
