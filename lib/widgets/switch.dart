import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/cupertino.dart';

class MySwitch extends StatelessWidget {
  final String text;
  final bool value, absorb;
  final void Function(bool?)? onChanged;

  const MySwitch(
    this.text, {
    required this.value,
    this.absorb = false,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AbsorbPointer(
        absorbing: absorb,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: style(fontSize: 16),
              ),
            ),
            const HorizontalSpacer(6),
            Transform.scale(
              scale: 0.9,
              child: CupertinoSwitch(
                value: value,
                activeColor: FCColors.prime,
                thumbColor:
                    value ? FCColors.primeLight : FCColors.blueGreyLight,
                trackColor: FCColors.blueGreyDark,
                onChanged: (value) {
                  if (onChanged != null) {
                    onChanged!(value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
