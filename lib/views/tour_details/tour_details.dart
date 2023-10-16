import 'package:faircare/views/tour_details/app_bar.dart';
import 'package:faircare/views/tour_details/tour_map.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/horizontal_tile.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/switch.dart';
import 'package:flutter/material.dart';

class TourDetailsPage extends StatelessWidget {
  const TourDetailsPage({Key? key}) : super(key: key);

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
                children: const [
                  // overview
                  MyHeading('Übersicht'),
                  VerticalSpacer(12),
                  TourMap(),
                  VerticalSpacer(12),
                  VerticalSpacer(32),

                  // planning
                  MyHeading('Planung'),
                  VerticalSpacer(12),
                  HorizontalTile(
                    'Start/Ende',
                    mainText: '08:00 - 11:00',
                  ),
                  HorizontalTile(
                    'Vergütung',
                    mainText: '95 €',
                  ),
                  HorizontalTile(
                    'Geschätzter Stundenlohn',
                    mainText: '31,66 €',
                  ),
                  VerticalSpacer(32),

                  // details
                  MyHeading('Details'),
                  VerticalSpacer(12),
                  MySwitch(
                    'Hauswirtschaft',
                    value: true,
                    absorb: true,
                  ),
                  MySwitch(
                    'Wundversorgung',
                    value: true,
                    absorb: true,
                  ),
                  MySwitch(
                    'Grundpflege',
                    value: false,
                    absorb: true,
                  ),
                  MySwitch(
                    'Behandlungspflege',
                    value: false,
                    absorb: true,
                  ),
                  MySwitch(
                    'Infektionskrankheiten',
                    value: false,
                    absorb: true,
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
