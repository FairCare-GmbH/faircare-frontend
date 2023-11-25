import 'package:faircare/features/tours/tour_details/visit_map.widget.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/features/patients/patient.model.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/horizontal_tile.dart';
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
                  if (visit != null) const MyHeading('Planung'),
                  if (visit != null) const VerticalSpacer(12),

                  if (visit != null)
                    HorizontalTile(
                      'Fahrtzeit',
                      mainText:
                          '${((visit!.actualCommuteDuration ?? visit!.plannedCommuteDuration) ~/ 3600).toString().padLeft(1, '0')}h ${(((visit!.actualCommuteDuration ?? visit!.plannedCommuteDuration) % 3600) ~/ 60).toString().padLeft(2, '0')}m',
                    ),

                  if (visit != null)
                    HorizontalTile(
                      'Pflegestart',
                      mainText:
                          '${visit!.actualDurationMinutes != null ? ' / ' : ''}'
                          '${visit!.plannedStartTime.substring(0, 5)}',
                      secondaryText: visit!.actualDurationMinutes != null
                          ? visit!.actualStartTime!.substring(0, 5)
                          : '',
                      // secondaryColor: visit!.plannedDurationMinutes >=
                      //     (visit!.actualDurationMinutes ?? 0)
                      //     ? MyColors.green
                      //     : MyColors.red,
                    ),

                  if (visit != null)
                    HorizontalTile(
                      'Pflegezeit',
                      mainText:
                          '${visit!.actualDurationMinutes != null ? ' / ' : ''}'
                          '${(visit!.plannedCareDuration ~/ 3600).toString().padLeft(1, '0')}h ${((visit!.plannedCareDuration % 3600) ~/ 60).toString().padLeft(2, '0')}m',
                      secondaryText: visit!.actualDurationMinutes != null
                          ? '${(visit!.actualCareDuration! ~/ 3600).toString().padLeft(1, '0')}h ${((visit!.actualCareDuration! % 3600) ~/ 60).toString().padLeft(2, '0')}m'
                          : '',
                      secondaryColor: visit!.plannedCareDuration <=
                              (visit!.actualCareDuration ?? 0)
                          ? MyColors.green
                          : MyColors.red,
                    ),

                  // if (visit != null)
                  //   HorizontalTile(
                  //     'Pflegeende',
                  //     mainText:
                  //     '${visit!.actualDurationMinutes != null ? ' / ' : ''}'
                  //         '${visit!.plannedEndTime.substring(0, 5)}',
                  //     secondaryText: visit!.actualDurationMinutes != null
                  //         ? visit!.actualEndTime!.substring(0, 5)
                  //         : '',
                  //     secondaryColor: visit!.plannedDurationMinutes >=
                  //         (visit!.actualDurationMinutes ?? 0)
                  //         ? MyColors.green
                  //         : MyColors.red,
                  //   ),

                  if (visit != null)
                    HorizontalTile(
                      'Vergütung',
                      mainText:
                          '${visit!.myActualWageCents != null ? ' / ' : ''}'
                          '${(visit!.myPlannedWageCents / 100).toStringAsFixed(2)} €',
                      secondaryText: visit!.actualDurationMinutes != null
                          ? '${(visit!.myActualWageCents! / 100).toStringAsFixed(2)} €'
                          : '',
                      secondaryColor: visit!.myPlannedWageCents <=
                              (visit!.myActualWageCents ?? 0)
                          ? MyColors.green
                          : MyColors.red,
                    ),

                  // if (visit != null)
                  //   HorizontalTile(
                  //     'Bonus',
                  //     mainText: '',
                  //     secondaryText:
                  //         '${visit!.bonus > 0 ? '+' : ''} ${((visit!.bonus) / 100).toStringAsFixed(2)} €',
                  //     secondaryColor: (visit!.plannedCareDuration +
                  //                 visit!.plannedCommuteDuration) >=
                  //             ((visit!.actualCareDuration ?? 0) +
                  //                 (visit!.actualCommuteDuration ?? 0))
                  //         ? (visit!.bonus > 0 ? MyColors.green : MyColors.prime)
                  //         : MyColors.red,
                  //   ),

                  // HorizontalTile(
                  //   'Vergütung',
                  //   mainText:
                  //   '${state == TourState.completed ? ' / ' : ''}'
                  //       '${(((model.myPlannedWageCents ?? 0) + model.bonus) / 100).toStringAsFixed(2)} €',
                  //   secondaryText:
                  //       '${(((model.myActualWageCents ?? 0) + model.bonus) / 100).toStringAsFixed(2)} €',
                  //   secondaryColor: model.plannedDurationMinutes >=
                  //           (model.actualDurationMinutes ?? 0)
                  //       ? MyColors.green
                  //       : MyColors.red,
                  // ),
                  //
                  // // hourly rate
                  // HorizontalTile(
                  //   'Stundenlohn',
                  //   mainText: '${state == TourState.completed ? ' / ' : ''}'
                  //       '${(((model.myPlannedWageCents ?? 0) / (model.plannedDurationMinutes / 60)) / 100).toStringAsFixed(2)} €',
                  //   secondaryText: state == TourState.completed
                  //       ? '${(((model.myActualWageCents ?? 0) / ((model.actualDurationMinutes ?? 0) / 60)) / 100).toStringAsFixed(2)} €'
                  //       : '',
                  //   secondaryColor: model.plannedDurationMinutes >=
                  //           (model.actualDurationMinutes ?? 0)
                  //       ? MyColors.green
                  //       : MyColors.red,
                  // ),
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
