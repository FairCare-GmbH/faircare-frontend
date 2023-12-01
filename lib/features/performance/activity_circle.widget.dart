import 'dart:math';

import 'package:faircare/features/performance/performance_tabs.cubit.dart';
import 'package:faircare/features/performance/tour_list_performance_display_type.enum.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vector_math/vector_math.dart' as vmath;

class ActivityCircleWidget extends StatefulWidget {
  final int amountBonusCents;
  final int maxBonusCents;

  final double percentRating;
  final double percentPlanRating;

  final double percentTaskComplete;
  final double percentPlanTaskComplete;

  final double percentHours;
  final double percentPlanHours;

  const ActivityCircleWidget(
      {super.key,
      required this.amountBonusCents,
      required this.maxBonusCents,
      required this.percentRating,
      required this.percentPlanRating,
      required this.percentTaskComplete,
      required this.percentPlanTaskComplete,
      required this.percentHours,
      required this.percentPlanHours});

  @override
  State<StatefulWidget> createState() => ActivityCircleWidgetState();
}

class ActivityCircleWidgetState extends State<ActivityCircleWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _bonusAnimationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      value: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 750),
    );

    _bonusAnimationController = AnimationController(
      vsync: this,
      value: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 750),
    );

    _animationController.addListener(() => setState(() {}));
    _bonusAnimationController.addListener(() => setState(() {}));

    _animationController.forward();
  }

  // double ratingsCurveTransform(double rating) {
  //   List<double> threshholds = [
  //     //1.0,
  //     3.0,
  //     //3.5,
  //     //4.0,
  //     5,
  //   ];
  //
  //   //   {
  //   //     4.5: 1.1,
  //   //   4.0: 1.0,
  //   //   3.5: 0.75,
  //   //   3.0: 0.5,
  //   //   1.0: 0,
  //   // };
  //
  //   double multiplier = 0;
  //   for (var i = 0; i < threshholds.length; i++) {
  //     if (rating >= threshholds[i]) {
  //       multiplier += 1;
  //     } else {
  //       multiplier += (rating - i == 0 ? 0 : threshholds[i - 1]) /
  //           (threshholds[i] - i == 0 ? 0 : threshholds[i - 1]);
  //     }
  //   }
  //   return multiplier;
  // }

  @override
  Widget build(BuildContext context) {
    final xy = MediaQuery.of(context).size.width - 108;
    final strokeWidth = xy * .11;

    final List<double> degrees = [
      Curves.ease.transform(_animationController.value) *
          widget.percentHours *
          360,
      Curves.ease.transform(_animationController.value) *
          widget.percentTaskComplete *
          360,
      Curves.ease.transform(_animationController.value) *
          widget.percentRating *
          360,
    ];

    final List<double> planDegrees = [
      widget.percentPlanHours * 360,
      widget.percentPlanTaskComplete * 360,
      widget.percentPlanRating * 360,
    ];

    final isCenterLocked = degrees[2] < planDegrees[2] ||
        (degrees[0] < planDegrees[0] && degrees[1] < planDegrees[1]);

    if (!isCenterLocked &&
        !_bonusAnimationController.isAnimating &&
        !_bonusAnimationController.isCompleted) {
      _bonusAnimationController.forward();
    }

    // return GestureDetector(
    //   onTapUp: (TapUpDetails tud) {
    //     final center = Offset(xy / 2, xy / 2);
    //
    //     final List<Path> paths = degrees
    //         .map((d) => Path()
    //           ..addArc(
    //               Rect.fromCenter(
    //                   center: center,
    //                   width: xy -
    //                       strokeWidth * (degrees.indexOf(d) * 2 + 1) -
    //                       degrees.indexOf(d) * 6,
    //                   height: xy -
    //                       strokeWidth * (degrees.indexOf(d) * 2 + 1) -
    //                       degrees.indexOf(d) * 6),
    //               vmath.radians(-90),
    //               vmath.radians(min(360, d))))
    //         .toList(growable: false);
    //
    //     for (var i = 0; i < paths.length; i++) {
    //       if (paths[i].contains(tud.localPosition)) {
    //         print(tud.localPosition);
    //         if (callbacks[i] != null) {
    //           callbacks[i]!();
    //         }
    //         break;
    //       }
    //     }
    //   },
    //   child:
    return GestureDetector(
      onTapUp: (TapUpDetails tud) {
        final cubit = BlocProvider.of<PerformanceTabsCubit>(context);
        if (cubit == null) return;
        final center = Offset(xy / 2, xy / 2);
        final path = Path()
          ..addOval(Rect.fromCenter(
              center: center,
              width: xy -
                  strokeWidth * ((degrees.length - 1) * 2 + 1) -
                  (degrees.length - 1) * 6 +
                  12,
              height: xy -
                  strokeWidth * ((degrees.length - 1) * 2 + 1) -
                  (degrees.length - 1) * 6 +
                  12));
        if (path.contains(tud.localPosition)) {
          cubit.setSelectedIndex(TourListPerformanceDisplayType.totalBonus);
        }
      },
      child: SizedBox(
          height: xy,
          child:
              BlocBuilder<PerformanceTabsCubit, TourListPerformanceDisplayType>(
            builder:
                (BuildContext context, TourListPerformanceDisplayType state) =>
                    CustomPaint(
              painter: ActivityCirclePainter(
                isCenterSelected:
                    state == TourListPerformanceDisplayType.totalBonus,
                circleDegrees: degrees,
                planDegrees: planDegrees,
                isCenterLocked: isCenterLocked,
                width: xy,
                height: xy,
                strokeWidth: strokeWidth,
                innerFillPercentage: widget.maxBonusCents == 0
                    ? 0
                    : Curves.ease.transform(_bonusAnimationController.value) *
                        (widget.amountBonusCents / widget.maxBonusCents),
                centerText:
                    '${(Curves.ease.transform(_bonusAnimationController.value) * widget.amountBonusCents / 100).toStringAsFixed(0)}€',
                secondaryText:
                    'von ${(widget.maxBonusCents / 100).toStringAsFixed(0)}€',
                colors: const [
                  FCColors.primeDark,
                  FCColors.prime,
                  FCColors.indigo,
                  FCColors.yellow
                ],
                // centerText: (max(
                //         0,
                //         (Curves.ease.transform(_animationController.value) *
                //                     widget.hourlyRevenueCents -
                //                 2400) /
                //             100))
                //     .toStringAsFixed(2),
                // secondaryText: 'Bonus/h'
              ),
              child: Container(),
            ),
          )),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class ActivityCirclePainter extends CustomPainter {
  final List<double> circleDegrees;
  final List<double> planDegrees;
  final bool isCenterLocked;
  final double innerFillPercentage;
  final double width;
  final double height;
  final String? centerText;
  final String? secondaryText;
  final double strokeWidth;

  final List<Color> colors;

  final bool isCenterSelected;

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  ActivityCirclePainter({
    super.repaint,
    required this.innerFillPercentage,
    required this.isCenterLocked,
    required this.circleDegrees,
    required this.planDegrees,
    required this.width,
    required this.height,
    required this.strokeWidth,
    this.centerText,
    this.secondaryText,
    required this.colors,
    required this.isCenterSelected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Get the center of the canvas
    final center = Offset(size.width / 2, size.height / 2);

    if (isCenterLocked) {
      const icon = Icons.lock_outline;
      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          color: colors[circleDegrees.length],
          fontSize: strokeWidth * 1.4,
          fontFamily: icon.fontFamily,
          //fontWeight: FontWeight.bold,
          package: icon
              .fontPackage, // This line is mandatory for external icon packs
        ),
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(center.dx - strokeWidth / (2 / 1.4),
              center.dy - strokeWidth / (2 / 1.4)));
    } else {
      canvas.save();

      canvas.clipPath(Path()
        ..addOval(Rect.fromCenter(
            center: center,
            width: width -
                strokeWidth * (circleDegrees.length * 2) -
                circleDegrees.length * 6,
            height: height -
                strokeWidth * (circleDegrees.length * 2) -
                circleDegrees.length * 6)));

      // canvas.drawOval(
      //     Rect.fromCenter(
      //         center: center,
      //         width: width -
      //             strokeWidth * (1 + (circleDegrees.length - 1) * 2) -
      //             (circleDegrees.length - 1) * 6,
      //         height: (height -
      //                 strokeWidth * (1 + (circleDegrees.length - 1) * 2) -
      //                 (circleDegrees.length - 1) * 6) *
      //             innerFillPercentage),
      //     Paint()
      //       ..style = PaintingStyle.fill
      //       ..strokeCap = StrokeCap.butt
      //       ..color = FCColors.white
      //       ..strokeWidth = strokeWidth);

      final double circleHeight = (height -
              strokeWidth * (1 + (circleDegrees.length - 1) * 2) -
              (circleDegrees.length - 1) * 6) *
          innerFillPercentage;

      canvas.drawRect(
          Rect.fromCenter(
            center: Offset(
                size.width / 2,
                size.height / 2 +
                    (size.height -
                        strokeWidth * (circleDegrees.length * 2) -
                        circleDegrees.length * 6) -
                    circleHeight / 2),
            width: width -
                strokeWidth * (1 + (circleDegrees.length - 1) * 2) -
                (circleDegrees.length - 1) * 6,
            height: circleHeight,
          ),
          Paint()
            ..style = PaintingStyle.fill
            ..strokeCap = StrokeCap.butt
            ..color = colors[circleDegrees.length]
            ..strokeWidth = strokeWidth);

      if (centerText != null) {
        _textPainter.text = TextSpan(
            text: centerText,
            style: TextStyle(
                color: FCColors.blueGrey,
                fontSize: strokeWidth * .75,
                fontWeight: FontWeight.bold));
        _textPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
        _textPainter.paint(
            canvas,
            Offset(center.dx - _textPainter.width / 2,
                center.dy - _textPainter.height / 2));
      }

      if (secondaryText != null) {
        _textPainter.text = TextSpan(
            text: secondaryText,
            style:
                TextStyle(color: FCColors.grey, fontSize: strokeWidth * 0.3));
        _textPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
        _textPainter.paint(
            canvas,
            Offset(center.dx - _textPainter.width / 2,
                center.dy - _textPainter.height / 2 + strokeWidth * .5));
      }

      canvas.restore();
    }

    for (var c = 0; c < circleDegrees.length; c++) {
      // Draw the gray background seen on the progress indicator
      // This will act as the background layer.
      canvas.drawOval(
        Rect.fromCenter(
            center: center,
            width: width - strokeWidth * (1 + c * 2) - c * 6,
            height: height - strokeWidth * (1 + c * 2) - c * 6),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt
          ..color = colors[c % colors.length].withOpacity(.2)
          ..strokeWidth = strokeWidth,
      );

      // Create a new layer where we will be painting the
      // actual progress indicator
      // canvas.saveLayer(
      //   Rect.fromCenter(center: center, width: 200, height: 200),
      //   Paint(),
      // );

      // canvas.drawLine(
      //   Offset(center.dx, center.dy - 100),
      //   Offset(center.dx, center.dy - 70),
      //   Paint()
      //     ..style = PaintingStyle.stroke
      //     ..color = Colors.black38
      //     ..strokeWidth = 2,
      // );

      var d = circleDegrees[c];
      var i = 0;
      do {
        canvas.drawArc(
          Rect.fromCenter(
              center: center,
              width: width - strokeWidth * (1 + c * 2) - c * 6,
              height: height - strokeWidth * (1 + c * 2) - c * 6),
          vmath.radians(-90),
          vmath.radians(min(360, d)),
          false,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.butt
            ..color = (i == 0)
                ? colors[c % colors.length]
                : colors[(i + c) % colors.length]
            ..strokeWidth = strokeWidth,
        );

        d -= 360;
        i++;
      } while (d > 0);

      final radius = min(width, height) - strokeWidth * (1 + (c) * 2) - (c) * 6;

      canvas.drawLine(
        center +
            Offset(
                ((radius + strokeWidth) / 2) *
                    cos(vmath.radians(planDegrees[c] - 90)),
                ((radius + strokeWidth) / 2) *
                    sin(vmath.radians(planDegrees[c] - 90))),
        center +
            Offset(
                ((radius - strokeWidth) / 2) *
                    cos(vmath.radians(planDegrees[c] - 90)),
                ((radius - strokeWidth) / 2) *
                    sin(vmath.radians(planDegrees[c] - 90))),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt
          ..color = circleDegrees[c] >= planDegrees[c]
              ? colors[planDegrees.length]
              : colors[c]
          ..strokeWidth = 4,
      );

      if (isCenterLocked && circleDegrees[c] < planDegrees[c]) {
        const icon = Icons.lock_outline;
        TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
        textPainter.text = TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: TextStyle(
            color: colors[c],
            fontSize: 16,
            fontFamily: icon.fontFamily,
            //fontWeight: FontWeight.bold,
            package: icon
                .fontPackage, // This line is mandatory for external icon packs
          ),
        );
        textPainter.layout();

        canvas.save();
        final pivot = center +
            Offset(
                ((radius + 15) / 2) * cos(vmath.radians(planDegrees[c] - 90)),
                ((radius + 15) / 2) * sin(vmath.radians(planDegrees[c] - 90)));
        canvas.translate(pivot.dx, pivot.dy);
        canvas.rotate(vmath.radians(planDegrees[c] + 90));
        canvas.translate(-pivot.dx, -pivot.dy);

        textPainter.paint(canvas, pivot);
        canvas.restore();
      }
    }

    if (isCenterSelected) {
      canvas.drawOval(
        Rect.fromCenter(
            center: center,
            width: width -
                strokeWidth * (1 + (circleDegrees.length) * 2) +
                strokeWidth / 1.5,
            height: height -
                strokeWidth * (1 + (circleDegrees.length) * 2) +
                strokeWidth / 1.5),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt
          ..color = colors[colors.length - 1].withOpacity(.4)
          ..strokeWidth = strokeWidth / 3,
      );
    }

    // Draw the dark green portion of the progress indicator
    // Basically, this covers the entire progress indicator circle.
    // But because we have set the blending mode to srouce-in (BlendMode.srcIn),
    // only the segment that is overlapping with the lighter portion will be visible.
    // canvas.drawArc(
    //   Rect.fromCenter(center: center, width: 155, height: 155),
    //   vmath.radians(0),
    //   vmath.radians(360),
    //   false,
    //   Paint()
    //     ..style = PaintingStyle.stroke
    //     ..strokeCap = StrokeCap.round
    //     ..color = MyColors.prime
    //     ..strokeWidth = 15
    //     ..blendMode = BlendMode.srcIn,
    // );

    // we fatten the layer
    // canvas.saveLayer(
    //   Rect.fromCenter(center: center, width: 200, height: 200),
    //   Paint(),
    // );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
