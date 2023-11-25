import 'package:faircare/global/fc_colors.dart';
import 'package:flutter/material.dart';

import 'bottom_nav_bar_item.widget.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 72,
      child: Column(
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: FCColors.border,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                BottomNavBarItemWidget(
                  text: 'Angebot',
                  icon: Icons.inbox,
                  index: 0,
                ),
                BottomNavBarItemWidget(
                  text: 'Touren',
                  icon: Icons.drive_eta,
                  index: 1,
                ),
                BottomNavBarItemWidget(
                  text: 'Patienten',
                  icon: Icons.people,
                  index: 4,
                ),
                BottomNavBarItemWidget(
                  text: 'Leistung',
                  icon: Icons.pie_chart,
                  index: 2,
                ),
                // BottomNavItem(
                //   text: 'Präferenzen',
                //   icon: Icons.settings,
                //   index: 3,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
