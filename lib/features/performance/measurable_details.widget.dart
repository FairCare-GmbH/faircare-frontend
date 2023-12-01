import 'package:faircare/features/performance/measurable.model.dart';
import 'package:flutter/cupertino.dart';

import '../../global/fc_colors.dart';
import '../../widgets/horizontal_tile.dart';

class MeasurableDetailsWidget extends StatelessWidget {
  final Measurable measurable;

  const MeasurableDetailsWidget({super.key, required this.measurable});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      HorizontalTile(
        'Start/Ende',
        mainText: '${measurable.isClosed ? ' / ' : ''}'
            '${measurable.plannedStartTime.substring(0, 5)} - ${measurable.plannedEndTime.substring(0, 5)}',
        secondaryText: measurable.isClosed
            ? '${measurable.actualStartTime?.substring(0, 5)} - ${measurable.actualEndTime?.substring(0, 5)}'
            : '',
        secondaryColor: measurable.plannedWorkDurationMinutes >=
                (measurable.actualWorkDurationMinutes ?? 0)
            ? FCColors.green
            : FCColors.red,
      ),
      HorizontalTile(
        'Pflegezeit',
        mainText: '${measurable.actualCareDuration != null ? ' / ' : ''}'
            '${(measurable.plannedCareDuration ~/ 3600).toString().padLeft(1, '0')}h ${((measurable.plannedCareDuration % 3600) ~/ 60).toString().padLeft(2, '0')}m',
        secondaryText: measurable.actualCareDuration != null
            ? '${((measurable.actualCareDuration ?? 0) ~/ 3600).toString().padLeft(1, '0')}h ${(((measurable.actualCareDuration ?? 0) % 3600) ~/ 60).toString().padLeft(2, '0')}m'
            : '',
        secondaryColor: measurable.plannedCareDuration >=
                (measurable.actualCareDuration ?? 0)
            ? FCColors.green
            : FCColors.red,
      ),
      HorizontalTile(
        'Fahrtzeit',
        mainText: '${measurable.actualCommuteDuration != null ? ' / ' : ''}'
            '${(measurable.plannedCommuteDuration ~/ 3600).toString().padLeft(1, '0')}h ${((measurable.plannedCommuteDuration % 3600) ~/ 60).toString().padLeft(2, '0')}m',
        secondaryText: measurable.actualWorkDurationMinutes != null
            ? '${((measurable.actualCommuteDuration ?? 0) ~/ 3600).toString().padLeft(1, '0')}h ${(((measurable.actualCommuteDuration ?? 0) % 3600) ~/ 60).toString().padLeft(2, '0')}m'
            : '',
        secondaryColor: measurable.plannedCommuteDuration >=
                (measurable.actualCommuteDuration ?? 0)
            ? FCColors.green
            : FCColors.red,
      ),
      HorizontalTile(
        'Vergütung',
        mainText: '${measurable.myActualWageCents != null ? ' / ' : ''}'
            '${(measurable.myPlannedWageCents / 100).toStringAsFixed(2)} €',
        secondaryText: measurable.myActualWageCents != null
            ? '${(measurable.myActualWageCents! / 100).toStringAsFixed(2)} €'
            : '',
        secondaryColor:
            measurable.myPlannedWageCents <= (measurable.myActualWageCents ?? 0)
                ? FCColors.green
                : FCColors.red,
      ),
      if (measurable.isClosed)
        HorizontalTile(
          'Gesparte Zeit',
          mainText: '',
          secondaryText:
              '${measurable.actualWorkDurationMinutes! <= measurable.plannedWorkDurationMinutes ? '+' : '-'} ${((measurable.plannedWorkDurationMinutes - measurable.actualWorkDurationMinutes!).abs() ~/ 60).toString().padLeft(1, '0')}h ${((measurable.plannedWorkDurationMinutes - measurable.actualWorkDurationMinutes!).abs() % 60).toString().padLeft(2, '0')}m',
          secondaryColor: measurable.actualWorkDurationMinutes ==
                  measurable.plannedWorkDurationMinutes
              ? FCColors.darkGrey
              : measurable.actualWorkDurationMinutes! <=
                      measurable.plannedWorkDurationMinutes
                  ? FCColors.green
                  : FCColors.red,
        ),
      HorizontalTile(
        'Bonus',
        mainText: '',
        secondaryText:
            '${(measurable.maxBonus ?? 0) > 0 ? '+' : ''} ${((measurable.maxBonus ?? 0) / 100).toStringAsFixed(2)} €',
        secondaryColor: measurable.plannedWorkDurationMinutes >=
                (measurable.actualWorkDurationMinutes ?? 0)
            ? ((measurable.maxBonus ?? 0) > 0 ? FCColors.green : FCColors.prime)
            : FCColors.red,
      ),
    ]);
  }
}
