import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint, suffixText;
  final TextEditingController controller;
  final TextInputType type;
  final int lines;
  final bool obscure;
  final double radius;
  final FocusNode? focusNode;
  final Color? color;
  final TextAlign align;

  const MyTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.suffixText = '',
    this.obscure = false,
    this.type = TextInputType.text,
    this.color,
    this.lines = 1,
    this.radius = 32,
    this.focusNode,
    this.align = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color ?? MyColors.grey.withOpacity(0.1),
      ),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        obscureText: obscure,
        controller: controller,
        focusNode: focusNode,
        keyboardType: type,
        textAlign: align,
        style: style(fontSize: 16),
        maxLines: lines,
        cursorColor: MyColors.black,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 16),
          suffix: Text(suffixText, style: style()),
        ),
      ),
    );
  }
}
