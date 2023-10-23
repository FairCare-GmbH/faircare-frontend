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
  final Widget? child;
  final bool disabled;

  const Button(
    this.text, {
    this.child,
    this.icon,
    Key? key,
    this.onPressed,
    this.buttonColor = MyColors.prime,
    this.textColor = MyColors.white,
    this.height = 48,
    this.borderRadius = 16,
    this.padding = 4,
    this.textSize = 16,
    this.width = double.infinity,
    this.disabled = false,
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
          color: !disabled ? buttonColor : MyColors.grey,
          borderRadius: BorderRadius.circular(borderRadius),
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
                            color: textColor,
                          )
                        : const HorizontalSpacer(0),
                    HorizontalSpacer(icon != null ? 8 : 0),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: style(
                        color: textColor,
                        fontSize: textSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
