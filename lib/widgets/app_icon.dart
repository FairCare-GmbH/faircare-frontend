import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({this.size = 60, Key? key}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      height: size,
    );
  }
}
