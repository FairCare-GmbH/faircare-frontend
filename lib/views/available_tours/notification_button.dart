import 'package:faircare/global/colors.dart';
import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ),
        const Positioned(
          right: 14,
          top: 11,
          child: Center(
            child: CircleAvatar(
              radius: 3,
              backgroundColor: MyColors.prime,
            ),
          ),
        ),
      ],
    );
  }
}
