import 'dart:math';

import 'package:faircare/features/performance/activity_circle.widget.dart';
import 'package:faircare/features/performance/performance_app_bar.widget.dart';
import 'package:faircare/features/performance/performance_item.widget.dart';
import 'package:faircare/features/performance/performance_tab.widget.dart';
import 'package:faircare/features/performance/performance_tabs.cubit.dart';
import 'package:faircare/features/performance/tour_list_performance_display_type.enum.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/widgets/filter_chip.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import '../tours/tour.model.dart';
import 'completed_tours.bloc.dart';
import 'completed_tours_list.widget.dart';

class PerformanceView extends StatelessWidget {
  const PerformanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CompletedToursBloc>(
      create: (_) => CompletedToursBloc()
        ..add(GetCompletedTours(
            from: DateTime(DateTime.now().year, DateTime.now().month, 1),
            to: DateTime.now().ymd,
            searchType: 3)),
      child: BlocBuilder<CompletedToursBloc, CompletedToursState>(
          builder: (context, state) {
        return Column(
          children: [
            const PerformanceAppBarWidget(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                children: [
                  // filter
                  const MyHeading('Filter'),
                  const VerticalSpacer(12),
                  // timeframe filter
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        MyFilterChip(
                          'Dieser Monat',
                          selected: state is CompletedToursLoaded &&
                              state.searchType == 3,
                          onTap: () {
                            final today = DateTime.now().ymd;
                            BlocProvider.of<CompletedToursBloc>(context).add(
                                GetCompletedTours(
                                    from: DateTime(today.year, today.month, 1),
                                    to: today,
                                    searchType: 3));
                          },
                        ),
                        const HorizontalSpacer(12),
                        MyFilterChip(
                          'Letzter Monat',
                          selected: state is CompletedToursLoaded &&
                              state.searchType == 4,
                          onTap: () {
                            final today = DateTime.now().ymd;
                            final previousMonthStart =
                                DateTime(today.year, today.month - 1, 1);
                            final previousMonthEnd = DateTime(
                                    previousMonthStart.year,
                                    previousMonthStart.month + 1,
                                    1)
                                .subtract(const Duration(days: 1));
                            BlocProvider.of<CompletedToursBloc>(context).add(
                                GetCompletedTours(
                                    from: previousMonthStart,
                                    to: previousMonthEnd,
                                    searchType: 4));
                          },
                        ),
                        const HorizontalSpacer(12),
                        MyFilterChip(
                          'Diese Woche',
                          selected: state is CompletedToursLoaded &&
                              state.searchType == 1,
                          onTap: () {
                            final today = DateTime.now().ymd;
                            BlocProvider.of<CompletedToursBloc>(context).add(
                                GetCompletedTours(
                                    from: today.subtract(
                                        Duration(days: today.weekday - 1)),
                                    to: today,
                                    searchType: 1));
                          },
                        ),
                        const HorizontalSpacer(12),
                        MyFilterChip(
                          'Letzte Woche',
                          selected: state is CompletedToursLoaded &&
                              state.searchType == 2,
                          onTap: () {
                            final previousMonday = DateTime.now().ymd.subtract(
                                Duration(
                                    days: 7 + DateTime.now().ymd.weekday - 1));
                            BlocProvider.of<CompletedToursBloc>(context).add(
                                GetCompletedTours(
                                    from: previousMonday,
                                    searchType: 2,
                                    to: previousMonday
                                        .add(const Duration(days: 6))));
                          },
                        ),
                        const HorizontalSpacer(12),
                        MyFilterChip(
                          'Alle',
                          selected: state is CompletedToursLoaded &&
                              state.searchType == 0,
                          onTap: () {
                            BlocProvider.of<CompletedToursBloc>(context).add(
                                GetCompletedTours(
                                    from: DateTime.now()
                                        .ymd
                                        .subtract(const Duration(days: 90)),
                                    to: DateTime.now().ymd,
                                    searchType: 0));
                          },
                        ),
                      ],
                    ),
                  ),
                  const VerticalSpacer(32),

                  BlocBuilder<CompletedToursBloc, CompletedToursState>(
                      builder: (context, state) {
                    if (state is CompletedToursLoaded) {
                      final List<TourModel> tours = state.tours.isEmpty
                          ? []
                          : state.tours.where((e) => e.isClosed).toList();

                      final totalWageCents = (tours.isEmpty
                          ? 0
                          : tours
                              .map((e) => (Api.getUser()!.hourlyWage *
                                      (e.actualWorkDurationMinutes! / 60))
                                  .round())
                              .reduce((v, e) => v + e));

                      final bonusCents = (tours.isEmpty
                          ? 0
                          : state.tours
                              .map((e) => e.actualBonus ?? 0)
                              .reduce((v, e) => v + e));

                      final maxBonusCents = (tours.isEmpty
                          ? 0
                          : tours
                              .map((e) => e.maxBonus ?? 0)
                              .reduce((v, e) => v + e));

                      final actualWorkMinutes = tours.isNotEmpty
                          ? tours
                              .map((e) => e.actualWorkDurationMinutes!)
                              .reduce((v, e) => v + e)
                          : 0.0;

                      final plannedWorkMinutes = tours.isNotEmpty
                          ? tours
                              .map((e) => e.plannedWorkDurationMinutes)
                              .reduce((v, e) => v + e)
                          : 0.0;

                      final percentageTaskComplete = tours.isNotEmpty
                          ? tours
                                  .map((e) =>
                                      e.myActualCompletionPercentage ?? 0)
                                  .reduce((v, e) => v + e) /
                              tours.length
                          : 0.0;

                      final ratingCount = tours.isNotEmpty
                          ? tours.where((e) => e.rating != null).length
                          : 0;
                      final rating = ratingCount > 0
                          ? tours
                                  .where((e) => e.rating != null)
                                  .map((e) => e.rating!)
                                  .reduce((v, e) => v + e) /
                              ratingCount
                          : 0.0;
                      return Column(
                        children: [
                          SizedBox(
                            height: 80,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                PerformanceItemWidget(
                                  icon: Icons.euro,
                                  title: 'Einnahmen',
                                  count:
                                      '${((totalWageCents + (rating >= 3.75 ? bonusCents : 0)) / 100).toStringAsFixed(2)} €',
                                  tabDisplayType: TourListPerformanceDisplayType
                                      .totalWageAndBonus,
                                ),
                                const HorizontalSpacer(12),
                                PerformanceItemWidget(
                                  icon: Icons.timelapse,
                                  title: 'Arbeitstunden',
                                  count:
                                      '${(actualWorkMinutes ~/ 60).toString().padLeft(2)}h ${(actualWorkMinutes % 60).toString().padLeft(2)}m',
                                  tabDisplayType:
                                      TourListPerformanceDisplayType.workTime,
                                ),
                                const HorizontalSpacer(12),
                                PerformanceItemWidget(
                                  icon: Icons.work_outline,
                                  title: 'Stundenlohn',
                                  count:
                                      '${(actualWorkMinutes == 0 ? 0 : ((((rating >= 3.75 ? bonusCents : 0) + totalWageCents) / 100) / (actualWorkMinutes / 60))).toStringAsFixed(2)} €',
                                  tabDisplayType: TourListPerformanceDisplayType
                                      .hourlyWageAndBonus,
                                ),
                                const HorizontalSpacer(12),
                                PerformanceItemWidget(
                                  icon: Icons.directions_car,
                                  title: 'Touren',
                                  count: state.tours.length.toString(),
                                  tabDisplayType:
                                      TourListPerformanceDisplayType.chevron,
                                ),
                              ],
                            ),
                          ),
                          const VerticalSpacer(32),
                          ActivityCircleWidget(
                            percentRating: rating / 5.0,
                            percentPlanRating: 3.75 / 5.0,
                            percentTaskComplete: percentageTaskComplete,
                            percentPlanTaskComplete: .75,
                            percentHours:
                                (plannedWorkMinutes / actualWorkMinutes) * .75,
                            //means 132% * 24 €/hour = 31.71 €/hour is 100% on all marks
                            percentPlanHours: .75,
                            amountBonusCents: bonusCents,
                            maxBonusCents: maxBonusCents,
                          ),
                          const VerticalSpacer(12),
                          SizedBox(
                            height: 80,
                            child: BlocBuilder<PerformanceTabsCubit,
                                TourListPerformanceDisplayType>(
                              builder: (BuildContext context,
                                      TourListPerformanceDisplayType state) =>
                                  Row(
                                children: [
                                  PerformanceTabItemWidget(
                                    value: plannedWorkMinutes -
                                                actualWorkMinutes >=
                                            60
                                        ? '${((plannedWorkMinutes - actualWorkMinutes) / 60).toStringAsFixed(0)} h'
                                        : '${max(plannedWorkMinutes - actualWorkMinutes, 0)} m',
                                    description: 'Gesparte Zeit',
                                    color: FCColors.primeDark,
                                    tabDisplayType:
                                        TourListPerformanceDisplayType
                                            .workTimeFasterThanPlan,
                                  ),
                                  PerformanceTabItemWidget(
                                    value:
                                        '${(percentageTaskComplete * 100).toStringAsFixed(0)} %',
                                    description: 'Leistung',
                                    color: FCColors.prime,
                                    tabDisplayType:
                                        TourListPerformanceDisplayType
                                            .percentTaskComplete,
                                  ),
                                  PerformanceTabItemWidget(
                                    value: rating == 0
                                        ? '- Ø'
                                        : '${rating.toStringAsFixed(1)} Ø',
                                    description: 'Bewertung',
                                    color: FCColors.indigo,
                                    tabDisplayType:
                                        TourListPerformanceDisplayType.rating,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const VerticalSpacer(32),
                          const MyHeading('Abgeschlossene Touren'),
                          const VerticalSpacer(12),
                          BlocBuilder<PerformanceTabsCubit,
                                  TourListPerformanceDisplayType>(
                              builder: (BuildContext context,
                                      TourListPerformanceDisplayType state) =>
                                  CompletedToursListWidget(displayType: state)),
                        ],
                      );
                    } else {
                      return const LoadingIndicator();
                    }
                  }),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
