import 'package:faircare/views/my_tours/app_bar.dart';
import 'package:faircare/views/my_tours/assigned_tours_list.dart';
import 'package:faircare/views/my_tours/requested_tours_list.dart';
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
            children: const [
              // requested tours
              MyHeading('Angefragt'),
              VerticalSpacer(12),
              RequestedToursList(),
              VerticalSpacer(32),

              // assigned tours
              MyHeading('Zugewiesen'),
              VerticalSpacer(12),
              AssignedToursList(),
            ],
          ),
        )
      ],
    );
  }
}
