import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/checkbox_tile.dart';
import 'package:faircare/widgets/dropdown.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:flutter/material.dart';

class RegisterSecondPage extends StatefulWidget {
  const RegisterSecondPage({Key? key}) : super(key: key);

  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  final distances = [
    '1 Km',
    '3 Km',
    '5 Km',
    '10 Km',
    '15 Km',
  ];

  final find = [
    'FairCare Website',
    'Google',
    'Persönliche Empfehlung',
    'Facebook',
    'Instagram',
  ];

  var hoursRange = const RangeValues(30, 70);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        // available by
        InkWell(
          onTap: () {},
          child: AbsorbPointer(
            absorbing: true,
            child: MyDropdown(
              label: 'Verfügbar ab',
              value: '13.10.2003',
              items: const ['13.10.2003'],
              onChanged: (v) {},
            ),
          ),
        ),
        const VerticalSpacer(24),

        // distance
        MyDropdown(
          label: 'Maximale Distanz zum Start der Tour',
          value: distances[0],
          items: distances,
          onChanged: (v) {},
        ),
        const VerticalSpacer(24),

        // working hours
        Text(
          'Gewünschte Arbeitszeit in Stunden pro Woche',
          style: style(color: MyColors.grey),
        ),
        const VerticalSpacer(0),

        // select hours range
        RangeSlider(
          values: hoursRange,
          min: 0,
          max: 100,
          labels: RangeLabels(
            hoursRange.start.round().toString(),
            hoursRange.end.round().toString(),
          ),
          activeColor: MyColors.prime,
          inactiveColor: MyColors.border,
          onChanged: (RangeValues values) {},
        ),
        const VerticalSpacer(0),

        // select work type
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyTextButton(
              'Minijob',
              color: MyColors.grey,
              onTap: () {},
            ),
            MyTextButton(
              'Teilzeit',
              color: MyColors.prime,
              onTap: () {},
            ),
            MyTextButton(
              'Vollzeit',
              color: MyColors.grey,
              onTap: () {},
            ),
          ],
        ),
        const VerticalSpacer(16),

        // earnings
        Text.rich(
          TextSpan(
            text: 'Entspricht einem geschätzen durchschnittlichen '
                'Monatsgehalt von ca. ',
            children: [
              TextSpan(
                text: '960 € - 1920 €',
                style: style(color: MyColors.prime, fontSize: 13),
              ),
            ],
          ),
          style: style(color: MyColors.grey, fontSize: 13),
        ),
        const VerticalSpacer(24),

        // find us
        MyDropdown(
          label: 'Wie hast du von der App erfahren?',
          value: find[0],
          items: find,
          onChanged: (v) {},
        ),
        const VerticalSpacer(24),

        // terms
        CheckboxTile(
          textSecondary: 'Nutzungsbedingungen',
          textMain: ' akzeptieren',
          onTap: () {},
          onTextTap: () {},
        ),
        const VerticalSpacer(20),

        // data protection
        CheckboxTile(
          textSecondary: 'Datenschutzvereinbarung',
          textMain: ' akzeptieren',
          onTap: () {},
          onTextTap: () {},
        ),
      ],
    );
  }
}
