import 'package:faircare/widgets/dropdown.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_field.dart';
import 'package:flutter/material.dart';

class RegisterFirstPage extends StatefulWidget {
  const RegisterFirstPage({Key? key}) : super(key: key);

  @override
  State<RegisterFirstPage> createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final qualifications = [
    'Pflegefachkraft (3J Ausbildung)',
    'Pflegehilfskraft (1-2J Ausbildung)',
    'Ungelernte Pflegehilfskraft',
    'Keine Erfahrung in der Pflege',
  ];

  final driverLicense = [
    'Vorhanden',
    'Nicht vorhanden',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        // name
        MyTextField(
          label: 'Vollständiger Name',
          hint: 'Vollständiger Name',
          controller: nameController,
        ),
        const VerticalSpacer(24),

        // email
        MyTextField(
          label: 'E-Mail',
          hint: 'E-Mail',
          controller: emailController,
        ),
        const VerticalSpacer(24),

        // phone
        MyTextField(
          label: 'Telefonnummer',
          hint: 'Telefonnummer',
          controller: phoneController,
        ),
        const VerticalSpacer(24),

        // address
        MyTextField(
          label: 'Anschrift',
          hint: 'Anschrift',
          controller: addressController,
        ),
        const VerticalSpacer(24),

        // qualification
        MyDropdown(
          label: 'Qualifikation',
          value: qualifications[0],
          items: qualifications,
          onChanged: (v) {},
        ),
        const VerticalSpacer(24),

        // driver license
        MyDropdown(
          label: 'Führerschein',
          value: driverLicense[0],
          items: driverLicense,
          onChanged: (v) {},
        ),
      ],
    );
  }
}
