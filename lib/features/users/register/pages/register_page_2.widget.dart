import 'package:faircare/features/users/register/register_cubit.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/features/users/register/register.model.dart';
import 'package:faircare/widgets/checkbox_tile.dart';
import 'package:faircare/widgets/dropdown.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../dialogs/availability_dialog.dart';
import '../widgets/working_hours.widget.dart';

class RegisterSecondPageWidget extends StatefulWidget {
  const RegisterSecondPageWidget({Key? key}) : super(key: key);

  @override
  State<RegisterSecondPageWidget> createState() => _RegisterSecondPageWidgetState();
}

class _RegisterSecondPageWidgetState extends State<RegisterSecondPageWidget> {
  var hoursRange = const RangeValues(30, 70);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterModel>(
      builder: (context, state) {
        final cubit = BlocProvider.of<RegisterCubit>(context);

        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            // available by
            InkWell(
              onTap: () async {
                final date = await showAvailabilityDialog(context);
                if (date == null) return;
                cubit.setAvailability(date);
              },
              child: AbsorbPointer(
                absorbing: true,
                child: MyDropdown(
                  label: 'Verfügbar ab',
                  value: DateFormat('dd.MM.yyyy').format(state.availableFrom),
                  items: [
                    DateFormat('dd.MM.yyyy').format(state.availableFrom),
                  ],
                  onChanged: (v) {},
                ),
              ),
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
            const VerticalSpacer(24),

            // working hours
            const WorkingHoursWidget(),
            const VerticalSpacer(24),

            // source
            MyDropdown(
              label: 'Wie hast du von der App erfahren?',
              value: state.marketingSource,
              items: sources,
              onChanged: (v) {
                if (v == null) return;
                cubit.setMarketingSource(v);
              },
            ),
            const VerticalSpacer(24),

            // terms
            CheckboxTile(
              state.termsAgreed,
              textSecondary: 'Nutzungsbedingungen',
              textMain: ' akzeptieren',
              onTap: () {
                cubit.setTermsAgreement(!state.termsAgreed);
              },
              onTextTap: () {},
            ),
            const VerticalSpacer(20),

            // data protection
            CheckboxTile(
              state.dataProtectionAgreed,
              textSecondary: 'Datenschutzvereinbarung',
              textMain: ' akzeptieren',
              onTap: () {
                cubit.setDataProtectionAgreement(!state.dataProtectionAgreed);
              },
              onTextTap: () {},
            ),
          ],
        );
      },
    );
  }
}
