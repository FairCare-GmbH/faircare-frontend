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

import 'completed_tours.bloc.dart';

class MyRevenuesView extends StatelessWidget {
  const MyRevenuesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CompletedToursBloc>(
        create: (_) => CompletedToursBloc()..add(GetCompletedTours()),
        child: Column(
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
                          selected: true,
                          onTap: () {},
                        ),
                        const HorizontalSpacer(12),
                        MyFilterChip(
                          'Diese Woche',
                          onTap: () {},
                        ),
                        const HorizontalSpacer(12),
                        MyFilterChip(
                          'Letzte Woche',
                          onTap: () {},
                        ),
                        const HorizontalSpacer(12),
                        MyFilterChip(
                          'Dieser Monat',
                          onTap: () {},
                        ),
                        const HorizontalSpacer(12),
                        MyFilterChip(
                          'Letzter Monat',
                          onTap: () {},
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
                      final revenue = state.tours.isEmpty
                          ? 0
                          : state.tours
                              .map((e) => e.revenue + e.bonus)
                              .reduce((v, e) => v + e);
                      final hours = state.tours.isEmpty
                          ? 0
                          : state.tours
                                  .map((e) =>
                                      (e.actualEndTime!.time.hour * 60 +
                                          e.actualEndTime!.time.minute) -
                                      (e.actualStartTime!.time.hour * 60 -
                                          e.actualStartTime!.time.minute))
                                  .reduce((v, e) => v + e) /
                              60;
                      return SizedBox(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            RevenueItemsWidget(
                              icon: Icons.euro_symbol,
                              title: 'Einnahmen',
                              count: '$revenue €',
                            ),
                            const HorizontalSpacer(12),
                            RevenueItemsWidget(
                              icon: Icons.published_with_changes,
                              title: 'Stundenlohn',
                              count: '${hours == 0 ? 0 : (revenue / hours)} €',
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
        ));
  }
}
