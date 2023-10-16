import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/available_tours/tour_item.dart';
import 'package:faircare/views/my_tours/app_bar.dart';
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
            Text(
              'Angefragt',
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
              itemCount: 2,
              itemBuilder: (context, index) {
                return const TourItem();
              },
            ),
            const VerticalSpacer(32),

            // assigned tours
            Text(
              'Zugewiesen',
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
