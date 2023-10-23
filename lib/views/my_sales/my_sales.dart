import 'package:faircare/views/my_sales/app_bar.dart';
import 'package:faircare/views/my_sales/completed_tours_list.dart';
import 'package:faircare/views/my_sales/sales_item.dart';
import 'package:faircare/widgets/filter_chip.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class MySalesPage extends StatelessWidget {
  const MySalesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MySalesAppBar(),
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
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    SalesItem(
                      icon: Icons.euro_symbol,
                      title: 'Einnahmen',
                      count: '5017 €',
                    ),
                    HorizontalSpacer(12),
                    SalesItem(
                      icon: Icons.published_with_changes,
                      title: 'Stundenlohn',
                      count: '29 €',
                    ),
                    HorizontalSpacer(12),
                    SalesItem(
                      icon: Icons.directions_car,
                      title: 'Touren',
                      count: '2',
                    ),
                  ],
                ),
              ),
              const VerticalSpacer(32),

              // completed tours
              const MyHeading('Abgeschlossene Touren'),
              const VerticalSpacer(12),
              const CompletedToursList(),
            ],
          ),
        )
      ],
    );
  }
}
