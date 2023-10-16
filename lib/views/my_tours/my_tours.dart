import 'package:faircare/views/available_tours/tour_item.dart';
import 'package:faircare/views/my_tours/app_bar.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class MyToursPage extends StatelessWidget {
  const MyToursPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const MyToursAppBar(),
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          children: [
            // requested tours
            const MyHeading('Angefragt'),
            const VerticalSpacer(12),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (a, b) => const VerticalSpacer(12),
              itemCount: 2,
              itemBuilder: (context, index) {
                return const TourItem();
              },
            ),
            const VerticalSpacer(32),

            // assigned tours
            const MyHeading('Zugewiesen'),
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
