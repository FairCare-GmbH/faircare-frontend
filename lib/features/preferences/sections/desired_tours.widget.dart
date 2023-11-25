import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

import '../calendar/calendar.widget.dart';

class DesiredToursWidget extends StatelessWidget {
  const DesiredToursWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Subheading('Gewünschte Touren'),
        const VerticalSpacer(12),

        // calendar
        const CalendarWidget(),
        const VerticalSpacer(12),

        // color information
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Aktive Touren',
              style: style(
                color: MyColors.green,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const HorizontalSpacer(4),
            Text(
              'Verfügbar',
              style: style(
                color: MyColors.prime,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const HorizontalSpacer(4),
            Text(
              'Urlaub',
              style: style(
                color: MyColors.darkGrey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const HorizontalSpacer(4),
            Text(
              'in Beantragung',
              style: style(
                color: MyColors.red,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
