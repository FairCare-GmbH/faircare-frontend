import 'package:faircare/global/colors.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/my_tours/tour_visit.model.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/patient.model.dart';
import '../tour_details/visit_details.page.dart';

class TourVisitItemWidget extends StatelessWidget {
  const TourVisitItemWidget(
    this.visit,
    this.patient, {
    Key? key,
  }) : super(key: key);

  final TourVisitModel visit;
  final PatientModel? patient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (visit.type == 1) {
          navigate(context, VisitDetailsPage(visit, patient!));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.lightGrey,
        ),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: visit.bonus > 0 ? MyColors.yellow : MyColors.prime,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: //model.fromDate.isSameDay(model.toDate)?
                    Text(
                  (visit.actualStartTime ?? visit.plannedStartTime)
                      .substring(0, 5),
                  style: style(
                    color: MyColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // : const Icon(
                //     Icons.all_inclusive,
                //     color: MyColors.white,
                //     size: 18,
                //   ),
              ),
            ),
            const HorizontalSpacer(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // model.fromDate.isSameDay(model.toDate)
                    visit.type == 1
                        ? '${patient!.firstName} ${patient!.lastName}'
                        : visit.type == 2
                            ? 'Pause'
                            : 'Koordinationszeit',
                    //: '${days[model.dayOfWeek]}s',
                    style: style(
                      color: visit.bonus > 0 ? MyColors.yellow : MyColors.prime,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // const VerticalSpacer(2),
                  // Text(
                  //   tourType[model.type - 1],
                  //   style: style(
                  //     color: MyColors.darkGrey,
                  //     fontSize: 13,
                  //   ),
                  // ),
                ],
              ),
            ),
            const HorizontalSpacer(12),
            Text(
              '${((visit.myActualWageCents ?? visit.myPlannedWageCents ?? 0) / 100).toStringAsFixed(2)} €',
              style: style(
                color: visit.bonus > 0 ? MyColors.yellow : MyColors.darkGrey,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
