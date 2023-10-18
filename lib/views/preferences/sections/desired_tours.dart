import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class DesiredTours extends StatelessWidget {
  const DesiredTours({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Subheading('Gewünschte Touren'),
        VerticalSpacer(12),
      ],
    );
  }
}
