import 'package:faircare/views/preferences/app_bar.dart';
import 'package:faircare/views/preferences/sections/desired_hours.dart';
import 'package:faircare/views/preferences/sections/desired_tours.dart';
import 'package:faircare/views/preferences/sections/general_prefs.dart';
import 'package:faircare/views/preferences/sections/vacations.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
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
            children: const [
              // general
              MyHeading('Allgemein'),
              VerticalSpacer(24),
              GeneralPreferences(),

              VerticalSpacer(24),

              // availability
              MyHeading('Verfügbarkeiten'),
              VerticalSpacer(20),

              // desired hours
              DesiredHours(),
              VerticalSpacer(32),

              // desired tours
              DesiredTours(),
              VerticalSpacer(32),

              // vacations
              Vacations(),
            ],
          ),
        )
      ],
    );
  }
}
