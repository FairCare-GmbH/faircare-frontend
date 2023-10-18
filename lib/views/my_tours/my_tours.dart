import 'package:faircare/global/constants.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/views/available_tours/tour_item.dart';
import 'package:faircare/views/my_tours/app_bar.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class MyToursPage extends StatelessWidget {
  const MyToursPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyToursAppBar(),
        Expanded(
          child: ListView(
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
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (a, b) => const VerticalSpacer(10),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return TourItem(defaultTour, TourType.requested);
                },
              ),
              const VerticalSpacer(32),

              // assigned tours
              const MyHeading('Zugewiesen'),
              const VerticalSpacer(12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (a, b) => const VerticalSpacer(10),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return TourItem(defaultTour, TourType.assigned);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
