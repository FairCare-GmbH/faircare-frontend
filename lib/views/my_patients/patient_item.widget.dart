import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/my_patients/patient_details.view.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

import '../../models/patient.model.dart';
import '../tour_details/visit_details.page.dart';

class PatientItemWidget extends StatelessWidget {
  const PatientItemWidget(
    this.patient, {
    Key? key,
  }) : super(key: key);

  final PatientModel patient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigate(context, PatientDetailsView(patient));
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
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: patient.pflegegrad != null
                    ? MyColors.prime
                    : MyColors.yellow,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: //model.fromDate.isSameDay(model.toDate)?
                    Text(
                  patient.pflegegrad?.toString() ?? 'V',
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
                    '${patient.firstName} ${patient.lastName}',

                    //: '${days[model.dayOfWeek]}s',
                    style: style(
                      color: patient.pflegegrad != null
                          ? MyColors.prime
                          : MyColors.yellow,
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
            InkWell(
              onTap: () {
                navigate(context, PatientDetailsView(patient));
              },
              child: const Icon(
                Icons.chevron_right,
                color: MyColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
