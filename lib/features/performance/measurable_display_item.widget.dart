import 'package:faircare/features/performance/measurable.model.dart';
import 'package:faircare/features/performance/performance_tabs.cubit.dart';
import 'package:faircare/features/performance/tour_list_performance_display_type.enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/fc_colors.dart';
import '../../global/text_style.dart';

class MeasurableDisplayItemWidget extends StatelessWidget {
  final Measurable measurable;

  const MeasurableDisplayItemWidget(
      {Key? key, this.displayType, required this.measurable})
      : super(key: key);

  final TourListPerformanceDisplayType? displayType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerformanceTabsCubit, TourListPerformanceDisplayType>(
      builder: (context, state) => switch (displayType ?? state) {
        TourListPerformanceDisplayType.nothing => Container(),
        TourListPerformanceDisplayType.totalWage => Text(
            '${((measurable.myActualWageCents ?? measurable.myPlannedWageCents) / 100).toStringAsFixed(2)} €',
            style: style(
              color: measurable.myActualWageCents == null
                  ? FCColors.darkGrey
                  : measurable.myActualWageCents! >=
                          measurable.myPlannedWageCents
                      ? FCColors.green
                      : FCColors.red,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        TourListPerformanceDisplayType.totalBonus => Text(
            '${((measurable.actualBonus ?? 0) / 100).toStringAsFixed(2)} €',
            style: style(
              color: (measurable.actualBonus ?? 0) == 0
                  ? FCColors.darkGrey
                  : (measurable.actualBonus ?? 0) > 0
                      ? FCColors.yellow
                      : FCColors.red,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        TourListPerformanceDisplayType.totalWageAndBonus => Container(),
        TourListPerformanceDisplayType.hourlyWageAndBonus => Text(
            '${((measurable.actualHourlyWageCents ?? measurable.plannedHourlyWageCents) / 100).toStringAsFixed(2)} €',
            style: style(
              color: (measurable.actualBonus ?? 0) == 0
                  ? FCColors.darkGrey
                  : (measurable.actualBonus ?? 0) > 0
                      ? FCColors.yellow
                      : FCColors.red,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        TourListPerformanceDisplayType.maxBonus => Text(
            '${((measurable.maxBonus ?? 0) / 100).toStringAsFixed(2)} €',
            style: style(
              color: measurable.maxBonus == 0
                  ? FCColors.darkGrey
                  : FCColors.yellow,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        TourListPerformanceDisplayType.maxHourlyWageAndBonus => Container(),
        TourListPerformanceDisplayType.workTime => Text(
            '${((measurable.actualWorkDurationMinutes ?? measurable.plannedWorkDurationMinutes) ~/ 60).toString().padLeft(1, '0')}h ${((measurable.actualWorkDurationMinutes ?? measurable.plannedWorkDurationMinutes) % 60).toString().padLeft(2, '0')}m',
            style: style(
              color: FCColors.darkGrey,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        TourListPerformanceDisplayType.workTimeFasterThanPlan => Text(
          '${measurable.actualWorkDurationMinutes! <= measurable.plannedWorkDurationMinutes ? '+' : '-'} ${((measurable.plannedWorkDurationMinutes - measurable.actualWorkDurationMinutes!).abs() ~/ 60).toString().padLeft(1, '0')}h ${((measurable.plannedWorkDurationMinutes - measurable.actualWorkDurationMinutes!).abs() % 60).toString().padLeft(2, '0')}m',
            style: style(
              color: measurable.actualWorkDurationMinutes ==
                      measurable.plannedWorkDurationMinutes
                  ? FCColors.darkGrey
                  : measurable.actualWorkDurationMinutes! <=
                          measurable.plannedWorkDurationMinutes
                      ? FCColors.green
                      : FCColors.red,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        TourListPerformanceDisplayType.plannedTaskCount => Container(),
        TourListPerformanceDisplayType.actualTaskCount => Container(),
        TourListPerformanceDisplayType.plannedAndActualTaskCount => Container(),
        TourListPerformanceDisplayType.percentTaskComplete => Text(
            '${((measurable.myActualCompletionPercentage ?? 0) * 100).toStringAsFixed(0)} %',
            style: style(
              color: FCColors.darkGrey,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        TourListPerformanceDisplayType.rating => Text(
            '${measurable.rating?.toStringAsFixed(1) ?? ' - '} Ø',
            style: style(
              color: measurable.rating == null
                  ? FCColors.darkGrey
                  : measurable.rating! < 3.75
                      ? FCColors.red
                      : measurable.rating! < 4
                          ? FCColors.orange
                          : measurable.rating! < 4.5
                              ? FCColors.green
                              : FCColors.yellow,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        TourListPerformanceDisplayType.chevron =>
          const Icon(Icons.chevron_right),
        TourListPerformanceDisplayType.startTime => Text(
            (measurable.isClosed
                    ? measurable.actualStartTime!
                    : measurable.plannedStartTime)
                .substring(0, 5),
            style: style(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
      },
    );
  }
}
