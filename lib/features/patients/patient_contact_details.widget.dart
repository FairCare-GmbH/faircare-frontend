import 'package:faircare/models/patient.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/horizontal_tile.dart';

class PatientContactDetailsWidget extends StatelessWidget {
  final PatientModel patient;

  const PatientContactDetailsWidget({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      HorizontalTile(
        'Telefon',
        mainText: patient.phone,
        onTap: () async {
          final phoneUri = Uri.parse('tel://${patient.phone}');
          if (!await launchUrl(phoneUri)) {
            throw 'Could not open phone.';
          }
        },
      ),
      HorizontalTile(
        'E-Mail',
        mainText: patient.email,
        onTap: () async {
          final emailUri = Uri.parse('mailto://${patient.email}');
          if (!await launchUrl(emailUri)) {
            throw 'Could not open email.';
          }
        },
      ),
      HorizontalTile(
        'Adresse',
        mainText: patient.address,
        onTap: () async {
          final googleUrl = Uri.parse(
              'https://www.google.com/maps/search/?api=1&query=${patient.latitude},${patient.longitude}');
          if (!await launchUrl(googleUrl)) {
            throw 'Could not open the map.';
          }
        },
      ),
    ]);
  }
}
