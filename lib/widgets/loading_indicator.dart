import 'package:faircare/global/colors.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(),
        const CircularProgressIndicator(
          color: MyColors.prime,
          strokeWidth: 2,
        ),
      ],
    );
  }
}
