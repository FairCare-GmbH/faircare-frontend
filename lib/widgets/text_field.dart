import 'package:faircare/global/fc_colors.dart';
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
  final Function(String)? onChanged;

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
      this.suffixWidget,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: style(color: FCColors.grey),
        ),
        const VerticalSpacer(6),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: color ?? FCColors.border,
            ),
          ),
          child: TextField(
            textAlignVertical: suffixWidget == null
                ? TextAlignVertical.top
                : TextAlignVertical.center,
            textCapitalization: TextCapitalization.sentences,
            obscureText: obscure,
            controller: controller,
            onChanged: onChanged,
            focusNode: focusNode,
            keyboardType: type,
            textAlign: align,
            style: style(fontSize: 16, color: FCColors.black),
            maxLines: lines,
            obscuringCharacter: '●',
            cursorColor: FCColors.black,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
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
