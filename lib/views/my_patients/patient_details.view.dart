import 'package:faircare/global/colors.dart';
import 'package:faircare/models/patient.model.dart';
import 'package:faircare/views/my_patients/patient_actions.widget.dart';
import 'package:faircare/views/my_patients/patient_contact_details.widget.dart';
import 'package:faircare/views/my_patients/patient_details_app_bar.widget.dart';
import 'package:faircare/views/my_tours/tour_visit.model.dart';
import 'package:faircare/views/tour_details/app_bar.dart';
import 'package:faircare/views/tour_details/visit_map.widget.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/horizontal_tile.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/button.dart';

class PatientDetailsView extends StatelessWidget {
  const PatientDetailsView(
    this.patient, {
    Key? key,
  }) : super(key: key);

  final PatientModel patient;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            PatientDetailsAppBarWidget(
                title: '${patient.firstName} ${patient.lastName}'),
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
                  const MyHeading('Kontakt'),
                  const VerticalSpacer(12),

                  PatientContactDetailsWidget(patient: patient),

                  const VerticalSpacer(24),

                  PatientActionsWidget(patient: patient),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
