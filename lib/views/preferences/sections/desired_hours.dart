import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/hours_slider.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:flutter/material.dart';

class DesiredHours extends StatelessWidget {
  const DesiredHours({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // working hours
        const Subheading('Gewünschte Arbeitszeit in Stunden'),
        const VerticalSpacer(0),

        // select hours range
        HoursSlider(
          min: 0,
          max: 100,
          selectedRange: const RangeValues(30, 70),
          onChanged: (val) {},
        ),
        const VerticalSpacer(0),

        // select work type
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyTextButton(
              'Minijob',
              color: MyColors.grey,
              onTap: () {},
            ),
            MyTextButton(
              'Teilzeit',
              color: MyColors.prime,
              onTap: () {},
            ),
            MyTextButton(
              'Vollzeit',
              color: MyColors.grey,
              onTap: () {},
            ),
          ],
        ),
        const VerticalSpacer(16),

        // earnings
        Text.rich(
          TextSpan(
            text: 'Entspricht einem geschätzen durchschnittlichen '
                'Monatsgehalt von ca. ',
            children: [
              TextSpan(
                text: '960 € - 1920 €',
                style: style(
                  color: MyColors.prime,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
          style: style(
            color: MyColors.grey,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
