import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField(
    this.controller, {
    this.onChanged,
    this.onCloseTap,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final void Function(String)? onChanged;
  final VoidCallback? onCloseTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7.5),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: style(fontSize: 18, color: FCColors.black),
        cursorColor: FCColors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 13,
          ),
          border: InputBorder.none,
          hintText: 'Suche',
          hintStyle: style(fontSize: 18),
          prefixIcon: const Icon(Icons.search, color: FCColors.black),
          suffixIcon: InkWell(
            onTap: onCloseTap,
            child: const Icon(
              Icons.close,
              color: FCColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
