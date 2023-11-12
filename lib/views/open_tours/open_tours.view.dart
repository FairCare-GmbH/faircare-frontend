import 'package:faircare/global/extensions.dart';
import 'package:faircare/views/open_tours/open_tours_list.widget.dart';
import 'package:faircare/widgets/filter_chip.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'open_tours.bloc.dart';
import 'open_tours_app_bar.widget.dart';

class OpenToursView extends StatelessWidget {
  const OpenToursView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OpenToursBloc()
        ..add(GetOpenTours(
            from: DateTime.now().ymd,
            to: DateTime.now().ymd.add(const Duration(days: 90)),
            searchType: 0)),
      child:
          BlocBuilder<OpenToursBloc, OpenToursState>(builder: (context, state) {
        return Column(
          children: [
            const OpenToursAppBar(),
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
                  // const VerticalSpacer(12),
                  //
                  // // preferences based filter
                  // SizedBox(
                  //   height: 40,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       MyFilterChip(
                  //         'Alle',
                  //         selected: true,
                  //         onTap: () {},
                  //       ),
                  //       const HorizontalSpacer(12),
                  //       MyFilterChip(
                  //         'Präferenzen',
                  //         onTap: () {},
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const VerticalSpacer(12),

                  // timeframe filter
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        MyFilterChip(
                          'Alle',
                          selected:
                              state is OpenToursLoaded && state.searchType == 0,
                          onTap: () {
                            BlocProvider.of<OpenToursBloc>(context).add(
                                GetOpenTours(
                                    from: DateTime.now().ymd,
                                    to: DateTime.now()
                                        .ymd
                                        .add(const Duration(days: 90)),
                                    searchType: 0));
                          },
                        ),
                        const HorizontalSpacer(12),
                        MyFilterChip(
                          'Diese Woche',
                          selected:
                              state is OpenToursLoaded && state.searchType == 1,
                          onTap: () {
                            final today = DateTime.now().ymd;
                            BlocProvider.of<OpenToursBloc>(context).add(
                                GetOpenTours(
                                    from: today,
                                    to: today
                                        .add(Duration(days: 7 - today.weekday)),
                                    searchType: 1));
                          },
                        ),
                        const HorizontalSpacer(12),
                        MyFilterChip(
                          'Nächste Woche',
                          selected:
                              state is OpenToursLoaded && state.searchType == 2,
                          onTap: () {
                            final nextMonday = DateTime.now().ymd.add(Duration(
                                days: 7 - DateTime.now().ymd.weekday + 1));
                            BlocProvider.of<OpenToursBloc>(context).add(
                                GetOpenTours(
                                    from: nextMonday,
                                    to: nextMonday.add(const Duration(days: 7)),
                                    searchType: 2));
                          },
                        ),
                        const HorizontalSpacer(12),
                        MyFilterChip(
                          'Dieser Monat',
                          selected:
                              state is OpenToursLoaded && state.searchType == 3,
                          onTap: () {
                            final today = DateTime.now().ymd;
                            BlocProvider.of<OpenToursBloc>(context).add(
                                GetOpenTours(
                                    from: today,
                                    to: DateTime(today.year, today.month + 1, 1)
                                        .subtract(const Duration(days: 1)),
                                    searchType: 3));
                          },
                        ),
                        const HorizontalSpacer(12),
                        MyFilterChip(
                          'Nächster Monat',
                          selected:
                              state is OpenToursLoaded && state.searchType == 4,
                          onTap: () {
                            final today = DateTime.now().ymd;
                            final nextMonthStart =
                                DateTime(today.year, today.month + 1, 1);
                            final nextMonthEnd = DateTime(nextMonthStart.year,
                                    nextMonthStart.month + 1, 1)
                                .subtract(const Duration(days: 1));
                            BlocProvider.of<OpenToursBloc>(context).add(
                                GetOpenTours(
                                    from: nextMonthStart,
                                    to: nextMonthEnd,
                                    searchType: 4));
                          },
                        ),
                      ],
                    ),
                  ),
                  // const VerticalSpacer(12),
                  //
                  // // frequency filter
                  // SizedBox(
                  //   height: 40,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       MyFilterChip(
                  //         'Alle',
                  //         selected: true,
                  //         onTap: () {},
                  //       ),
                  //       const HorizontalSpacer(12),
                  //       MyFilterChip(
                  //         'Einmalig',
                  //         onTap: () {},
                  //       ),
                  //       const HorizontalSpacer(12),
                  //       MyFilterChip(
                  //         'Regelmäßig',
                  //         onTap: () {},
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const VerticalSpacer(32),

                  // tours
                  const MyHeading('Touren'),
                  const VerticalSpacer(12),
                  const OpenToursListWidget(),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
