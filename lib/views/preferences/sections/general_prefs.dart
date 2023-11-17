import 'package:faircare/global/constants.dart';
import 'package:faircare/widgets/dropdown.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/switch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/loading_indicator.dart';
import '../../../widgets/text_field.dart';
import '../state/preferences.bloc.dart';

class GeneralPreferences extends StatelessWidget {
  TextEditingController? addressController;

  GeneralPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferenceState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<PreferencesBloc>(context);

        if (state is PreferenceLoaded) {
          return Column(
            children: [
              // address
              MyTextField(
                label: 'Anschrift',
                hint: 'Anschrift',
                controller: addressController ??=
                    TextEditingController(text: state.userModel.address),
                onChanged: (address) {
                  bloc.add(UpdatePreferenceUser(
                      state.userModel.copyWith(address: address)));
                },
              ),
              const VerticalSpacer(24),
              MyDropdown(
                label: 'Verfügbar für neue Patienten',
                value: availableForNewPatients[
                    state.userModel.openForPatients ? 0 : 1],
                items: availableForNewPatients,
                onChanged: (v) {
                  if (v == null) return;
                  bloc.add(UpdatePreferenceUser(state.userModel.copyWith(
                      openForPatients: v == availableForNewPatients[0])));
                  //cubit.setAvailability(v == availableForNewPatients[0]);
                },
              ),
              const VerticalSpacer(24),

              // distance
              MyDropdown(
                label: 'Maximale Distanz zum Start der Tour',
                value: '${state.userModel.maximumCareRadius.toInt()} Km',
                items: distances.map((e) => '$e Km').toList(),
                onChanged: (v) {
                  if (v == null) return;
                  bloc.add(UpdatePreferenceUser(state.userModel.copyWith(
                      maximumCareRadius:
                          double.parse(v.toString().split(' ')[0]))));
                },
              ),
              const VerticalSpacer(16),
              MySwitch(
                'Hauswirtschaft',
                value: state.userModel.allowHousekeeping,
                onChanged: (v) {
                  bloc.add(UpdatePreferenceUser(state.userModel.copyWith(
                      allowHousekeeping:
                          v ?? !state.userModel.allowHousekeeping)));
                },
              ),
              MySwitch(
                'Wundversorgung',
                value: state.userModel.allowWoundCare,
                onChanged: (v) {
                  bloc.add(UpdatePreferenceUser(state.userModel.copyWith(
                      allowWoundCare: v ?? !state.userModel.allowWoundCare)));
                },
              ),
              MySwitch(
                'Grundpflege',
                value: state.userModel.allowBasicCare,
                onChanged: (v) {
                  bloc.add(UpdatePreferenceUser(state.userModel.copyWith(
                      allowBasicCare: v ?? !state.userModel.allowBasicCare)));
                },
              ),
              MySwitch(
                'Behandlungspflege',
                value: state.userModel.allowMedicalCare,
                onChanged: (v) {
                  bloc.add(UpdatePreferenceUser(state.userModel.copyWith(
                      allowMedicalCare:
                          v ?? !state.userModel.allowMedicalCare)));
                },
              ),
              MySwitch(
                'Betreuung',
                value: state.userModel.allowCompanionship,
                onChanged: (v) {
                  bloc.add(UpdatePreferenceUser(state.userModel.copyWith(
                      allowCompanionship:
                          v ?? !state.userModel.allowCompanionship)));
                },
              ),
              MySwitch(
                'Infektionskrankheiten',
                value: state.userModel.allowInfectiousDisease,
                onChanged: (v) {
                  bloc.add(UpdatePreferenceUser(state.userModel.copyWith(
                      allowInfectiousDisease:
                          v ?? !state.userModel.allowInfectiousDisease)));
                },
              ),
            ],
          );
        } else if (state is PreferenceError) {
          if (kDebugMode) {
            print(state.error);
            print(state.stack);
          }
          return Text(state.error.toString());
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }
}
