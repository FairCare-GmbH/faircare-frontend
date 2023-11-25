import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../preferences/calendar/calendar.widget.dart';

class VacationDetailsView extends StatelessWidget {
  const VacationDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => pop(context),
            icon: const Icon(CupertinoIcons.back, size: 28),
          ),
          centerTitle: true,
          title: Text(
            '09.09.2023',
            style: style(
              fontSize: 20,
              color: FCColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // calendar
            const CalendarWidget(isVacationPlanner: true),
            const VerticalSpacer(16),

            // from-to dates
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Von',
                        style: style(fontSize: 16),
                      ),
                      const HorizontalSpacer(8),
                      Text(
                        '29.10.2023',
                        style: style(
                          fontSize: 16,
                          color: FCColors.prime,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Bis',
                        style: style(fontSize: 16),
                      ),
                      const HorizontalSpacer(8),
                      Text(
                        '31.10.2023',
                        style: style(
                          fontSize: 16,
                          color: FCColors.prime,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const VerticalSpacer(16),

            // selected vacation dates
            Row(
              children: [
                Text(
                  'Ausgewählte Urlaubstage',
                  style: style(fontSize: 16),
                ),
                const HorizontalSpacer(12),
                Text(
                  '3',//TODO display number of vacation days
                  style: style(
                    fontSize: 16,
                    color: FCColors.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const VerticalSpacer(16),

            // offered tours
            const Subheading('Folgende Touren werden dabei abgegeben:'),
            const VerticalSpacer(12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (a, b) => const VerticalSpacer(10),
              itemCount: 0,
              itemBuilder: (context, index) {
                return null;
              
                // return TourItem(tourExample1, TourState.assigned);
              },
            ),
          ],
        ),
      ),
    );
  }
}
