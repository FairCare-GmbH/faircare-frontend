import 'package:faircare/features/performance/performance_tabs.cubit.dart';
import 'package:faircare/features/performance/tour_list_performance_display_type.enum.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PerformanceTabItemWidget extends StatelessWidget {
  const PerformanceTabItemWidget({
    required this.value,
    required this.description,
    required this.tabDisplayType,
    this.color = FCColors.prime,
    Key? key,
  }) : super(key: key);

  final String value, description;
  final Color color;
  final TourListPerformanceDisplayType tabDisplayType;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<PerformanceTabsCubit, TourListPerformanceDisplayType>(
        builder: (BuildContext context, TourListPerformanceDisplayType state) =>
            Container(
          decoration: BoxDecoration(
              border: tabDisplayType == state
                  ? const Border(
                      bottom: BorderSide(color: FCColors.yellow, width: 2))
                  : null),
          child: InkWell(
            onTap: () => BlocProvider.of<PerformanceTabsCubit>(context)
                .setSelectedIndex(tabDisplayType),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: style(
                    color: color,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const VerticalSpacer(2),
                Text(
                  description,
                  style: style(
                    color: FCColors.darkGrey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
