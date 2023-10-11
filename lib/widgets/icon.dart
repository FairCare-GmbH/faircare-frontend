import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String icon;
  final double size;
  final Color color;

  const SvgIcon({
    Key? key,
    required this.icon,
    required this.color,
    this.size = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$icon.svg',
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      height: size,
    );
  }
}
