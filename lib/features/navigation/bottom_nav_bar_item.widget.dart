import 'package:faircare/features/navigation/nav_bar.cubit.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarItemWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final int index;

  const BottomNavBarItemWidget({
    required this.text,
    required this.icon,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, int>(
      builder: (context, state) {
        return Expanded(
          child: InkWell(
            onTap: () {
              BlocProvider.of<NavBarCubit>(context).setIndex(index);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: index == state ? FCColors.prime : FCColors.darkGrey,
                  ),
                  const VerticalSpacer(4),
                  Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: style(
                      fontSize: 12,
                      color:
                          index == state ? FCColors.prime : FCColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
