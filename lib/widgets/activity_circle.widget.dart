import 'dart:math';
import 'dart:ui';

import 'package:faircare/global/colors.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vmath;

class ActivityCircleWidget extends StatefulWidget {
  final int hourlyRevenueCents;
  final double rating;

  const ActivityCircleWidget({
    super.key,
    required this.hourlyRevenueCents,
    required this.rating,
  });

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
      duration: const Duration(seconds: 1),
    );

    _animationController.addListener(() => setState(() {}));

    _animationController.forward();
  }

  double ratingsCurveTransform(double rating) {
    List<double> threshholds = [
      //1.0,
      3.0,
      //3.5,
      //4.0,
      5,
    ];

    //   {
    //     4.5: 1.1,
    //   4.0: 1.0,
    //   3.5: 0.75,
    //   3.0: 0.5,
    //   1.0: 0,
    // };

    double multiplier = 0;
    for (var i = 0; i < threshholds.length; i++) {
      if (rating >= threshholds[i]) {
        multiplier += 1;
      } else {
        multiplier += (rating - i == 0 ? 0 : threshholds[i - 1]) /
            (threshholds[i] - i == 0 ? 0 : threshholds[i - 1]);
      }
    }
    return multiplier;
  }

  @override
  Widget build(BuildContext context) {
    const width = 100.0;
    const height = 100.0;

    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
              child: CustomPaint(
            painter: ActivityCirclePainter(
                degrees: Curves.ease.transform(_animationController.value) *
                    (widget.hourlyRevenueCents / 2400) *
                    360,
                width: width,
                height: height,
                centerText: (max(
                        0,
                        (Curves.ease.transform(_animationController.value) *
                                    widget.hourlyRevenueCents -
                                2400) /
                            100))
                    .toStringAsFixed(2),
                secondaryText: 'Bonus/h'),
            child: Container(),
          )),
          Text('X',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: min(width, height) * .20)),
          Expanded(
              child: CustomPaint(
            painter: ActivityCirclePainter(
              degrees: Curves.ease.transform(_animationController.value) *
                  (widget.rating / 3.5) *
                  360,
              width: width,
              height: height,
              centerText: (Curves.ease.transform(_animationController.value) *
                      widget.rating)
                  .toStringAsFixed(1),
              secondaryText: 'Bewert.',
            ),
            child: Container(),
          )),
          Text('=',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: min(width, height) * .20)),
          Expanded(
            child: Container(),
          ),
        ],
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
  final double degrees;
  final double width;
  final double height;
  final String centerText;
  final String? secondaryText;

  final List<Color> colors;

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  ActivityCirclePainter(
      {super.repaint,
      required this.degrees,
      required this.width,
      required this.height,
      required this.centerText,
      this.colors = const [
        MyColors.prime,
        MyColors.yellow,
        MyColors.orange,
        MyColors.red
      ],
      this.secondaryText = null});

  @override
  void paint(Canvas canvas, Size size) {
    // Get the center of the canvas
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = min(width, height) * .15;

    // Draw the gray background seen on the progress indicator
    // This will act as the background layer.
    canvas.drawOval(
      Rect.fromCenter(
          center: center,
          width: width - strokeWidth,
          height: height - strokeWidth),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt
        ..color = MyColors.border
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

    var d = degrees;
    var i = 0;
    do {
      canvas.drawArc(
        Rect.fromCenter(
            center: center,
            width: width - strokeWidth,
            height: height - strokeWidth),
        vmath.radians(-90),
        vmath.radians(min(360, d)),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt
          ..color = colors[i % (colors.length - 1)]
          ..strokeWidth = strokeWidth,
      );

      d -= 360;
      i++;
    } while (d > 0);

    _textPainter.text = TextSpan(
        text: centerText,
        style: TextStyle(color: MyColors.black, fontSize: strokeWidth * 1.6));
    _textPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    _textPainter.paint(
        canvas,
        Offset(center.dx - _textPainter.width / 2,
            center.dy - _textPainter.height / 2));

    if (secondaryText != null) {
      _textPainter.text = TextSpan(
          text: secondaryText,
          style: TextStyle(color: MyColors.grey, fontSize: strokeWidth * 0.8));
      _textPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
      _textPainter.paint(
          canvas,
          Offset(center.dx - _textPainter.width / 2,
              center.dy - _textPainter.height / 2 + strokeWidth));
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
