import 'package:faircare/global/global.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.05,
      child: Image.asset(
        'assets/images/bg.png',
        width: width(context),
      ),
    );
  }
}
