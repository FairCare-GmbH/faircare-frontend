import 'package:faircare/features/performance/measurable_display_item.widget.dart';
import 'package:faircare/features/performance/tour_list_performance_display_type.enum.dart';
import 'package:faircare/features/tours/visit.model.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

import '../patients/patient.model.dart';
import 'tour_details/patient_visit_details.view.dart';

class PatientVisitListItemWidget extends StatelessWidget {
  const PatientVisitListItemWidget({
    this.visit,
    this.patient,
    this.displayType,
    Key? key,
  }) : super(key: key);

  final VisitModel? visit;
  final PatientModel? patient;
  final TourListPerformanceDisplayType? displayType;

  @override
  Widget build(BuildContext context) {
    if (visit == null && patient == null) {
      throw Exception("can't both be null");
    }
    return InkWell(
      onTap: () {
        if (patient != null) {
          navigate(
              context,
              PatientVisitDetailsView(
                patient: patient!,
                visit: visit,
              ));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: FCColors.lightGrey,
        ),
        child: Row(
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: patient?.pflegegrad != null
                    ? FCColors.prime
                    : visit?.type == 1 || patient != null
                        ? FCColors.primeDark
                        : FCColors.grey,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: //model.fromDate.isSameDay(model.toDate)?
                    Text(
                  patient == null
                      ? (visit!.type == 2
                          ? 'P'
                          : visit!.type == 4
                              ? (visit!.patientId == 1 ? 'S' : 'W')
                              : throw Exception('unknown type'))
                      : (patient!.pflegegrad?.toString() ?? 'V'),
                  style: style(
                    color: FCColors.white,
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
                    visit == null || visit?.type == 1
                        ? '${patient!.lastName}, ${patient!.firstName}'
                        : visit?.type == 2
                            ? 'Pause'
                            : visit?.type == 4
                                ? (visit?.patientId == 1
                                    ? 'Koordinationszeit'
                                    : visit?.patientId == 2
                                        ? 'Dienstbesprechung'
                                        : 'Verwaltungstätigkeit')
                                : throw Exception('unknown type'),
                    //: '${days[model.dayOfWeek]}s',
                    style: style(
                      color: patient?.pflegegrad != null
                          ? FCColors.prime
                          : visit?.type == 1 || patient != null
                              ? FCColors.primeDark
                              : FCColors.grey,
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
            visit == null
                ? const Icon(Icons.chevron_right)
                : MeasurableDisplayItemWidget(
                    measurable: visit!,
              displayType: displayType,
                  )
          ],
        ),
      ),
    );
  }
}
