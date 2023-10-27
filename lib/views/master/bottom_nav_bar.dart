import 'package:faircare/global/colors.dart';
import 'package:faircare/views/master/bottom_nav_item.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 72,
      child: Column(
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: MyColors.border,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                BottomNavItem(
                  text: 'Offene Touren',
                  icon: Icons.location_on,
                  index: 0,
                ),
                BottomNavItem(
                  text: 'Meine Touren',
                  icon: Icons.person_pin_circle,
                  index: 1,
                ),
                BottomNavItem(
                  text: 'Umsätze',
                  icon: Icons.bar_chart,
                  index: 2,
                ),
                BottomNavItem(
                  text: 'Präferenzen',
                  icon: Icons.settings,
                  index: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
