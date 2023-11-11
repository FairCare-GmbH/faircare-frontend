import 'package:faircare/views/open_tours/open_tours_list.widget.dart';
import 'package:faircare/widgets/filter_chip.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

import 'open_tours_app_bar.widget.dart';

class OpenToursView extends StatelessWidget {
  const OpenToursView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const VerticalSpacer(12),

              // preferences based filter
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
                      'Präferenzen',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
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
                      'Nächste Woche',
                      onTap: () {},
                    ),
                    const HorizontalSpacer(12),
                    MyFilterChip(
                      'Dieser Monat',
                      onTap: () {},
                    ),
                    const HorizontalSpacer(12),
                    MyFilterChip(
                      'Nächster Monat',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const VerticalSpacer(12),

              // frequency filter
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
                      'Einmalig',
                      onTap: () {},
                    ),
                    const HorizontalSpacer(12),
                    MyFilterChip(
                      'Regelmäßig',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
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
  }
}
