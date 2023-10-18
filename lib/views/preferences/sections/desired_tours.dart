import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/preferences/calendar_widget.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class DesiredTours extends StatelessWidget {
  const DesiredTours({Key? key}) : super(key: key);

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
          children: [
            Text(
              'Aktive Touren',
              style: style(
                color: MyColors.green,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const HorizontalSpacer(4),
            Text(
              'Freie Verfügbarkeiten',
              style: style(
                color: MyColors.prime,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const HorizontalSpacer(4),
            Text(
              'Urlaub',
              style: style(
                color: MyColors.darkGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const HorizontalSpacer(4),
            Text(
              'in Beantragung',
              style: style(
                color: MyColors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
