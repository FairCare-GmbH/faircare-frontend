import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: MyColors.prime,
        content: Text(
          text,
          style: style(
            fontSize: 16,
            color: MyColors.white,
          ),
        ),
      ),
    );
}
