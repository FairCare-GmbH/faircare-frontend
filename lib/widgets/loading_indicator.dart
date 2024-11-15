import 'package:faircare/global/fc_colors.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(),
          const CircularProgressIndicator(
            color: FCColors.prime,
            strokeWidth: 2,
          ),
        ],
      ),
    );
  }
}
