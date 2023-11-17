import 'package:faircare/global/colors.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/models/patient.model.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:faircare/views/my_tours/tour_visit.model.dart';
import 'package:faircare/views/my_tours/tour_visits_list.widget.dart';
import 'package:faircare/views/tour_details/app_bar.dart';
import 'package:faircare/views/tour_details/dialogs/cancel_give_back_dialog.dart';
import 'package:faircare/views/tour_details/dialogs/give_back_dialog.dart';
import 'package:faircare/views/tour_details/dialogs/request_dialog.dart';
import 'package:faircare/views/tour_details/tour_map.dart';
import 'package:faircare/views/tour_details/visit_map.widget.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/horizontal_tile.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/api.dart';

class VisitDetailsPage extends StatelessWidget {
  const VisitDetailsPage(
    this.visit,
    this.patient, {
    Key? key,
  }) : super(key: key);

  final TourVisitModel visit;
  final PatientModel patient;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ToursDetailsAppBar(
                title: visit.type == 1
                    ? '${patient.firstName} ${patient.lastName}'
                    : visit.type == 2
                        ? 'Pause'
                        : 'Koordinationszeit'),
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
                  const MyHeading('Planung'),
                  const VerticalSpacer(12),

                  // start and end time
                  HorizontalTile(
                    'Start/Ende',
                    mainText:
                        '${visit.actualStartTime != null && visit.actualEndTime != null ? ' / ' : ''}'
                        '${visit.plannedStartTime.substring(0, 5)} - ${visit.plannedEndTime.substring(0, 5)}',
                    secondaryText: visit.actualStartTime != null &&
                            visit.actualEndTime != null
                        ? '${visit.actualStartTime!.substring(0, 5)} - ${visit.actualEndTime!.substring(0, 5)}'
                        : '',
                    secondaryColor: (visit.plannedCareDuration +
                                visit.plannedCommuteDuration) >=
                            ((visit.actualCareDuration ?? 0) +
                                (visit.actualCommuteDuration ?? 0))
                        ? MyColors.green
                        : MyColors.red,
                  ),

                  HorizontalTile(
                    'Adresse',
                    mainText: patient.address,
                    onTap: () async {
                      final googleUrl = Uri.parse(
                          'https://www.google.com/maps/search/?api=1&query=${patient.latitude},${patient.longitude}');
                      if (!await launchUrl(googleUrl)) {
                        throw 'Could not open the map.';
                      }
                    },
                  ),

                  HorizontalTile(
                    'Vergütung',
                    mainText:
                        '${((visit.myActualWageCents ?? 0) / 100).toStringAsFixed(2)} €',
                  ),

                  HorizontalTile(
                    'Bonus',
                    mainText: '',
                    secondaryText:
                        '${visit.bonus > 0 ? '+' : ''} ${((visit.bonus) / 100).toStringAsFixed(2)} €',
                    secondaryColor: (visit.plannedCareDuration +
                                visit.plannedCommuteDuration) >=
                            ((visit.actualCareDuration ?? 0) +
                                (visit.actualCommuteDuration ?? 0))
                        ? (visit.bonus > 0 ? MyColors.green : MyColors.prime)
                        : MyColors.red,
                  ),

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
                  const VerticalSpacer(24),

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
