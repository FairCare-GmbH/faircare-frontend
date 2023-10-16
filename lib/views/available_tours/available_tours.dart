import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/available_tours/app_bar.dart';
import 'package:faircare/views/available_tours/filter_chip.dart';
import 'package:faircare/views/available_tours/tour_item.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class AvailableToursPage extends StatelessWidget {
  const AvailableToursPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const AvailableToursAppBar(),
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          children: [
            // filter
            Text(
              'Filter',
              style: style(
                fontSize: 18,
                color: MyColors.prime,
                fontWeight: FontWeight.w500,
              ),
            ),
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
            Text(
              'Touren',
              style: style(
                fontSize: 18,
                color: MyColors.prime,
                fontWeight: FontWeight.w500,
              ),
            ),
            const VerticalSpacer(12),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (a, b) => const VerticalSpacer(12),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const TourItem();
              },
            ),
          ],
        )
      ],
    );
  }
}
