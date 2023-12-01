import 'package:faircare/features/patients/patient.model.dart';
import 'package:faircare/features/performance/measurable_details.widget.dart';
import 'package:faircare/features/tours/tour_details/visit_map.widget.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

import '../../patients/patient_actions.widget.dart';
import '../../patients/patient_contact_details.widget.dart';
import '../../patients/patient_details_app_bar.widget.dart';
import '../tour_visit.model.dart';

class PatientVisitDetailsView extends StatelessWidget {
  const PatientVisitDetailsView({
    this.visit,
    required this.patient,
    Key? key,
  }) : super(key: key);

  final TourVisitModel? visit;
  final PatientModel patient;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            PatientDetailsAppBarWidget(
                title: '${patient.lastName}, ${patient.firstName}'),
            // overview

            VisitMapWidget(
                latitude: patient.latitude,
                longitude: patient.longitude,
                obfuscate: false),
            const VerticalSpacer(2),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                children: [
                  // planning
                  if (visit != null) const MyHeading('Planung'),
                  if (visit != null) const VerticalSpacer(12),

                  if (visit != null)
                    MeasurableDetailsWidget(
                      measurable: visit!,
                    ),

                  if (visit != null) const VerticalSpacer(24),
                  const MyHeading('Kontakt'),
                  const VerticalSpacer(12),
                  PatientContactDetailsWidget(patient: patient),
                  const VerticalSpacer(24),
                  PatientActionsWidget(patient: patient),

                  // const MyHeading('Leistungen'),
                  // const VerticalSpacer(12),
                  // MySwitch(
                  //   'Hauswirtschaft',
                  //   value: visit.hasHousekeeping,
                  //   absorb: true,
                  // ),
                  // const VerticalSpacer(12),
                  //
                  // if (visit.ownerNurseId == Api.getUser()!.id)
                  //   TourVisitsListWidget(tourId: visit.id),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
