import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onPressed;
  final Color buttonColor, textColor;
  final double height, width, borderRadius, padding, textSize;
  final bool outlined;
  final Widget? child;

  const Button(
    this.text, {
    this.child,
    this.icon,
    Key? key,
    this.onPressed,
    this.buttonColor = MyColors.prime,
    this.textColor = MyColors.white,
    this.height = 48,
    this.borderRadius = 32,
    this.padding = 4,
    this.textSize = 16,
    this.width = double.infinity,
    this.outlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: outlined ? Colors.transparent : buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: !outlined ? Colors.transparent : buttonColor,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: child != null
                ? [child!]
                : [
                    icon != null
                        ? Icon(
                            icon,
                            size: 22,
                            color: outlined ? buttonColor : textColor,
                          )
                        : const HorizontalSpacer(0),
                    HorizontalSpacer(icon != null ? 8 : 0),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: style(
                        color: outlined ? buttonColor : textColor,
                        fontSize: textSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
