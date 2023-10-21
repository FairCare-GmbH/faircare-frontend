import 'package:faircare/global/colors.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:faircare/views/tour_details/app_bar.dart';
import 'package:faircare/views/tour_details/dialogs/cancel_give_back_dialog.dart';
import 'package:faircare/views/tour_details/dialogs/cancel_request_dialog.dart';
import 'package:faircare/views/tour_details/dialogs/give_back_dialog.dart';
import 'package:faircare/views/tour_details/dialogs/request_dialog.dart';
import 'package:faircare/views/tour_details/tour_map.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/horizontal_tile.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/switch.dart';
import 'package:flutter/material.dart';

class TourDetailsPage extends StatelessWidget {
  const TourDetailsPage(
    this.model,
    this.state, {
    Key? key,
  }) : super(key: key);

  final TourModel model;
  final TourType state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const ToursDetailsAppBar(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                children: [
                  // overview
                  const MyHeading('Übersicht'),
                  const VerticalSpacer(12),
                  const TourMap(),
                  const VerticalSpacer(12),
                  const VerticalSpacer(24),

                  // planning
                  const MyHeading('Planung'),
                  const VerticalSpacer(12),
                  const HorizontalTile(
                    'Start/Ende',
                    mainText: '08:00 - 11:00',
                  ),
                  const HorizontalTile(
                    'Vergütung',
                    mainText: '95 €',
                  ),
                  const HorizontalTile(
                    'Geschätzter Stundenlohn',
                    mainText: '31,66 €',
                  ),
                  const VerticalSpacer(24),

                  // details
                  const MyHeading('Details'),
                  const VerticalSpacer(12),
                  const MySwitch(
                    'Hauswirtschaft',
                    value: true,
                    absorb: true,
                  ),
                  const MySwitch(
                    'Wundversorgung',
                    value: true,
                    absorb: true,
                  ),
                  const MySwitch(
                    'Grundpflege',
                    value: false,
                    absorb: true,
                  ),
                  const MySwitch(
                    'Behandlungspflege',
                    value: false,
                    absorb: true,
                  ),
                  const MySwitch(
                    'Infektionskrankheiten',
                    value: false,
                    absorb: true,
                  ),
                  const VerticalSpacer(12),

                  if (state == TourType.available)
                    Button(
                      'Anfragen',
                      onPressed: () {
                        showRequestDialog(context);
                      },
                    ),
                  if (state == TourType.requested)
                    Button(
                      'Zurückziehen',
                      onPressed: () {
                        showCancelRequestDialog(context);
                      },
                    ),
                  if (state == TourType.assigned)
                    Button(
                      'Abgeben',
                      onPressed: () {
                        showGiveBackDialog(context);
                      },
                    ),
                  if (state == TourType.givenBack)
                    Button(
                      'Abgabe abbrechen',
                      buttonColor: MyColors.red,
                      onPressed: () {
                        showCancelGiveBackDialog(context);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
