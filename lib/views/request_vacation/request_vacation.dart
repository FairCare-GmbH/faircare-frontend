import 'package:faircare/global/colors.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/available_tours/tour_item.dart';
import 'package:faircare/views/request_vacation/calendar/calendar_widget.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VacationPage extends StatelessWidget {
  const VacationPage({Key? key}) : super(key: key);

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
            'Urlaub beantragen',
            style: style(
              fontSize: 20,
              color: MyColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // calendar
            const VacationCalendarWidget(),
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
                          color: MyColors.prime,
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
                        'Biz',
                        style: style(fontSize: 16),
                      ),
                      const HorizontalSpacer(8),
                      Text(
                        '31.10.2023',
                        style: style(
                          fontSize: 16,
                          color: MyColors.prime,
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
                  '3 / 22',
                  style: style(
                    fontSize: 16,
                    color: MyColors.darkGrey,
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
              itemCount: 1,
              itemBuilder: (context, index) {
                return TourItem(tourExample1, TourState.assigned);
              },
            ),
            const VerticalSpacer(12),
            Button(
              'Beantragen',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
