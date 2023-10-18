import 'package:faircare/global/enums.dart';
import 'package:faircare/views/preferences/vacation_item.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class Vacations extends StatelessWidget {
  const Vacations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Subheading('Urlaubsanträge'),
        const VerticalSpacer(12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (a, b) => const VerticalSpacer(10),
          itemCount: 3,
          itemBuilder: (context, index) {
            return VacationItem(
              VacationType.values[index],
            );
          },
        ),
        const VerticalSpacer(12),
        Button(
          'Urlaub beantragen',
          onPressed: () {},
        ),
      ],
    );
  }
}
