import 'package:faircare/views/preferences/preferences_app_bar.widget.dart';
import 'package:faircare/views/preferences/sections/desired_hours.dart';
import 'package:faircare/views/preferences/sections/desired_tours.dart';
import 'package:faircare/views/preferences/sections/general_prefs.dart';
import 'package:faircare/views/preferences/sections/vacations.dart';
import 'package:faircare/views/preferences/state/preferences.bloc.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencesView extends StatefulWidget {
  const PreferencesView({Key? key}) : super(key: key);

  @override
  State<PreferencesView> createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PreferencesBloc()..add(GetPreferenceData()),
      child: Column(
        children: [
          const PreferencesAppBarWidget(),
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
      ),
    );
  }
}
