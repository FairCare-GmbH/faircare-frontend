import 'package:faircare/features/performance/performance_tabs.cubit.dart';
import 'package:faircare/features/performance/tour_list_performance_display_type.enum.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/text_style.dart';
import '../../widgets/spacer.dart';

class PerformanceItemWidget extends StatelessWidget {
  const PerformanceItemWidget({
    required this.icon,
    required this.title,
    required this.count,
    required this.tabDisplayType,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String title, count;
  final TourListPerformanceDisplayType tabDisplayType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerformanceTabsCubit, TourListPerformanceDisplayType>(
      builder: (BuildContext context, TourListPerformanceDisplayType state) =>
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: tabDisplayType == state
                    ? const Border(
                        bottom: BorderSide(color: FCColors.yellow, width: 2))
                    : null,
                color: FCColors.primeLightest,
              ),
              child: InkWell(
                onTap: () => BlocProvider.of<PerformanceTabsCubit>(context)
                    .setSelectedIndex(tabDisplayType),
                child: Row(
                  children: [
                    Icon(icon, color: FCColors.prime, size: 36),
                    const HorizontalSpacer(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: style(
                            color: FCColors.darkGrey,
                            fontSize: 13,
                          ),
                        ),
                        const VerticalSpacer(2),
                        Text(
                          count,
                          style: style(
                            color: FCColors.prime,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
    );
  }
}
