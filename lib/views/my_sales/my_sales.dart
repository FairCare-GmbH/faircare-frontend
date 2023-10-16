import 'package:faircare/views/available_tours/tour_item.dart';
import 'package:faircare/views/my_sales/app_bar.dart';
import 'package:faircare/views/my_sales/sales_item.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class MySalesPage extends StatelessWidget {
  const MySalesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const MySalesAppBar(),
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          children: [
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
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (a, b) => const VerticalSpacer(12),
              itemCount: 2,
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
