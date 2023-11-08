import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/user_dialog/user_image.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class ToursDetailsAppBar extends StatelessWidget {
  const ToursDetailsAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const UserImage(),
              const HorizontalSpacer(12),
              Expanded(
                child: Text(
                  title,
                  style: style(
                    color: MyColors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => pop(context),
              )
            ],
          ),
        ),
        const Divider(height: 8),
      ],
    );
  }
}
