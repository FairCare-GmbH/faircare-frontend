import 'package:faircare/global/extensions.dart';
import 'package:faircare/views/my_revenues/completed_tours_list.widget.dart';
import 'package:faircare/views/my_revenues/my_revenues_app_bar.widget.dart';
import 'package:faircare/views/my_revenues/revenue_items.widget.dart';
import 'package:faircare/widgets/filter_chip.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/tour_model.dart';
import 'completed_tours.bloc.dart';

class MyRevenuesView extends StatelessWidget {
  const MyRevenuesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CompletedToursBloc>(
      create: (_) => CompletedToursBloc()
        ..add(GetCompletedTours(
            from: DateTime.now().ymd.subtract(const Duration(days: 90)),
            to: DateTime.now().ymd,
            searchType: 0)),
      child: BlocBuilder<CompletedToursBloc, CompletedToursState>(
          builder: (context, state) {
        return Column(
          children: [
            const MyRevenuesAppBarWidget(),
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
                      ],
                    ),
                  ),
                  const VerticalSpacer(32),

                  // overview
                  const MyHeading('Übersicht'),
                  const VerticalSpacer(12),
                  BlocBuilder<CompletedToursBloc, CompletedToursState>(
                      builder: (context, state) {
                    if (state is CompletedToursLoaded) {
                      final revenue = (state.tours.isEmpty
                              ? 0
                              : state.tours
                                  .map((e) => e.revenue + e.bonus)
                                  .reduce((v, e) => v + e)) /
                          100;

                      final List<TourModel> tours = state.tours.isEmpty
                          ? []
                          : state.tours
                          .where((e) =>
                      e.actualStartTime != null &&
                          e.actualEndTime != null).toList();

                      final hours = tours.isNotEmpty ?
                                  tours.map((e) =>
                                      (e.actualEndTime!.time.hour * 60 +
                                          e.actualEndTime!.time.minute) -
                                      (e.actualStartTime!.time.hour * 60 -
                                          e.actualStartTime!.time.minute))
                                  .reduce((v, e) => v + e) /
                              60 : 0;
                      return SizedBox(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            RevenueItemsWidget(
                              icon: Icons.euro_symbol,
                              title: 'Einnahmen',
                              count: '${revenue.toStringAsFixed(2)} €',
                            ),
                            const HorizontalSpacer(12),
                            RevenueItemsWidget(
                              icon: Icons.published_with_changes,
                              title: 'Stundenlohn',
                              count:
                                  '${(hours == 0 ? 0 : (revenue / hours)).toStringAsFixed(2)} €',
                            ),
                            const HorizontalSpacer(12),
                            RevenueItemsWidget(
                              icon: Icons.hourglass_bottom,
                              title: 'Arbeitstunden',
                              count: hours.toStringAsFixed(1),
                            ),
                            const HorizontalSpacer(12),
                            RevenueItemsWidget(
                              icon: Icons.directions_car,
                              title: 'Touren',
                              count: state.tours.length.toString(),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const LoadingIndicator();
                    }
                  }),
                  const VerticalSpacer(32),

                  // completed tours
                  const MyHeading('Abgeschlossene Touren'),
                  const VerticalSpacer(12),
                  const CompletedToursListWidget(),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
