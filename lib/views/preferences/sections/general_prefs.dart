import 'package:faircare/blocs/preferences/preferences_cubit/preferences_cubit.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/models/preferences_model.dart';
import 'package:faircare/widgets/dropdown.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralPreferences extends StatelessWidget {
  const GeneralPreferences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesCubit, PreferencesModel>(
      builder: (context, state) {
        final cubit = BlocProvider.of<PreferencesCubit>(context);

        return Column(
          children: [
            // availability
            MyDropdown(
              label: 'Verfügbar für neue Patienten',
              value: availableForNewPatients[state.openForPatients ? 0 : 1],
              items: availableForNewPatients,
              onChanged: (v) {
                if (v == null) return;
                cubit.setAvailability(v == availableForNewPatients[0]);
              },
            ),
            const VerticalSpacer(24),

            // distance
            MyDropdown(
              label: 'Maximale Distanz zum Start der Tour',
              value: '${state.maximumCareRadius} Km',
              items: distances.map((e) => '$e Km').toList(),
              onChanged: (v) {
                if (v == null) return;
                cubit.setDistance(
                  int.parse(v.toString().split(' ')[0]),
                );
              },
            ),
            const VerticalSpacer(16),
            MySwitch(
              'Hauswirtschaft',
              value: state.allowHousekeeping,
              onChanged: (v) {
                cubit.setHousekeeping(!state.allowHousekeeping);
              },
            ),
            MySwitch(
              'Wundversorgung',
              value: state.allowWoundCare,
              onChanged: (v) {
                cubit.setWoundCare(!state.allowWoundCare);
              },
            ),
            MySwitch(
              'Grundpflege',
              value: state.allowBasicCare,
              onChanged: (v) {
                cubit.setBasicCare(!state.allowBasicCare);
              },
            ),
            MySwitch(
              'Behandlungspflege',
              value: state.allowMedicalCare,
              onChanged: (v) {
                cubit.setMedicalCare(!state.allowMedicalCare);
              },
            ),
            MySwitch(
              'Infektionskrankheiten',
              value: state.allowInfectiousDisease,
              onChanged: (v) {
                cubit.setInfectiousDisease(!state.allowInfectiousDisease);
              },
            ),
          ],
        );
      },
    );
  }
}
