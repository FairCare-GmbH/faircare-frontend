import 'dart:math';

import 'package:faircare/global/fc_colors.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vmath;

class ActivityCircleWidget extends StatefulWidget {
  final double percentBonus;
  final double percentRating;
  final double percentServiceComplete;
  final Function? onPercentBonusTap;
  final Function? onPercentRatingTap;
  final Function? onPercentServiceCompleteTap;

  const ActivityCircleWidget(
      {super.key,
      required this.percentBonus,
      required this.percentRating,
      required this.percentServiceComplete,
      this.onPercentBonusTap,
      this.onPercentRatingTap,
      this.onPercentServiceCompleteTap});

  @override
  State<StatefulWidget> createState() => ActivityCircleWidgetState();
}

class ActivityCircleWidgetState extends State<ActivityCircleWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      value: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 750),
    );

    _animationController.addListener(() => setState(() {}));

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
    final xy = MediaQuery.of(context).size.width - 102;
    final strokeWidth = xy * .11;

    final List<double> degrees = [
      Curves.ease.transform(_animationController.value) *
          widget.percentBonus *
          360,
      Curves.ease.transform(_animationController.value) *
          widget.percentRating *
          360,
      Curves.ease.transform(_animationController.value) *
          widget.percentServiceComplete *
          360,
    ];

    final List<Function?> callbacks = [
      widget.onPercentBonusTap,
      widget.onPercentRatingTap,
      widget.onPercentServiceCompleteTap
    ];

    return InkWell(
      onTapUp: (TapUpDetails tud) {
        final center = Offset(xy / 2, xy / 2);

        final List<Path> paths = degrees
            .map((d) => Path()
              ..addArc(
                  Rect.fromCenter(
                      center: center,
                      width: xy -
                          strokeWidth * (degrees.indexOf(d) * 2 + 1) -
                          degrees.indexOf(d) * 6,
                      height: xy -
                          strokeWidth * (degrees.indexOf(d) * 2 + 1) -
                          degrees.indexOf(d) * 6),
                  vmath.radians(-90),
                  vmath.radians(min(360, d))))
            .toList(growable: false);

        for (var i = 0; i < paths.length; i++) {
          if (paths[i].contains(tud.localPosition)) {
            if (callbacks[i] != null) {
              callbacks[i]!();
            }
            break;
          }
        }
      },
      child: SizedBox(
        height: xy,
        child: CustomPaint(
          painter: ActivityCirclePainter(
            degrees: degrees,
            width: xy,
            height: xy,
            strokeWidth: strokeWidth,
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
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class ActivityCirclePainter extends CustomPainter {
  final List<double> degrees;
  final double width;
  final double height;
  final String? centerText;
  final String? secondaryText;
  final double strokeWidth;

  final List<Color> colors;

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  ActivityCirclePainter({
    super.repaint,
    required this.degrees,
    required this.width,
    required this.height,
    required this.strokeWidth,
    this.centerText,
    this.secondaryText,
    this.colors = const [
      FCColors.prime,
      FCColors.yellow,
      FCColors.orange,
      FCColors.red
    ],
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Get the center of the canvas
    final center = Offset(size.width / 2, size.height / 2);

    for (var c = 0; c < degrees.length; c++) {
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

      var d = degrees[c];
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

      if (centerText != null) {
        _textPainter.text = TextSpan(
            text: centerText,
            style:
                TextStyle(color: FCColors.black, fontSize: strokeWidth * 1.1));
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
                TextStyle(color: FCColors.grey, fontSize: strokeWidth * 0.55));
        _textPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
        _textPainter.paint(
            canvas,
            Offset(center.dx - _textPainter.width / 2,
                center.dy - _textPainter.height / 2 + strokeWidth));
      }
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
    // canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
