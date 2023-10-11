import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint, suffixText;
  final String label;
  final TextEditingController controller;
  final TextInputType type;
  final int lines;
  final bool obscure;
  final double radius;
  final FocusNode? focusNode;
  final Color? color;
  final TextAlign align;
  final Widget? suffixWidget;

  const MyTextField(
      {Key? key,
      required this.hint,
      required this.label,
      required this.controller,
      this.suffixText = '',
      this.obscure = false,
      this.type = TextInputType.text,
      this.color,
      this.lines = 1,
      this.radius = 16,
      this.focusNode,
      this.align = TextAlign.start,
      this.suffixWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: style(color: MyColors.grey),
        ),
        const VerticalSpacer(6),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: color ?? MyColors.border,
            ),
          ),
          child: TextField(
            textAlignVertical: suffixWidget == null
                ? TextAlignVertical.top
                : TextAlignVertical.center,
            textCapitalization: TextCapitalization.sentences,
            obscureText: obscure,
            controller: controller,
            focusNode: focusNode,
            keyboardType: type,
            textAlign: align,
            style: style(fontSize: 16, color: MyColors.black),
            maxLines: lines,
            obscuringCharacter: '●',
            cursorColor: MyColors.black,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 0,
              ),
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 16),
              // suffix: suffixWidget,
              suffixIcon: suffixWidget,
            ),
          ),
        ),
      ],
    );
  }
}
