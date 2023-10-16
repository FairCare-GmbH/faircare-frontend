import 'package:faircare/views/preferences/app_bar.dart';
import 'package:faircare/widgets/dropdown.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/switch.dart';
import 'package:flutter/material.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final availableForNewPatients = [
    'Verfügbar',
    'Nicht verfügbar',
  ];

  final distances = [
    '1 Km',
    '3 Km',
    '5 Km',
    '10 Km',
    '15 Km',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PreferencesAppBar(),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            children: [
              // general
              const MyHeading('Allgemein'),
              const VerticalSpacer(24),
              MyDropdown(
                label: 'Verfügbar für neue Patienten',
                value: availableForNewPatients[0],
                items: availableForNewPatients,
                onChanged: (v) {},
              ),
              const VerticalSpacer(24),
              MyDropdown(
                label: 'Maximale Distanz zum Start der Tour',
                value: distances[0],
                items: distances,
                onChanged: (v) {},
              ),
              const VerticalSpacer(16),
              MySwitch(
                'Hauswirtschaft',
                value: true,
                onChanged: (v) {},
              ),
              MySwitch(
                'Wundversorgung',
                value: true,
                onChanged: (v) {},
              ),
              MySwitch(
                'Grundpflege',
                value: false,
                onChanged: (v) {},
              ),
              MySwitch(
                'Behandlungspflege',
                value: false,
                onChanged: (v) {},
              ),
              MySwitch(
                'Infektionskrankheiten',
                value: false,
                onChanged: (v) {},
              ),
              const VerticalSpacer(24),

              // availability
              const MyHeading('Verfügbarkeiten'),
              const VerticalSpacer(12),
            ],
          ),
        )
      ],
    );
  }
}
