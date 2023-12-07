import 'package:flutter/material.dart';
import 'dart:math';

class ArcPainter extends CustomPainter {
  final int finalValue;
  final int currentValue;
  final Color barColor;
  final Color fillColor;
  final double arcWidth;
  final bool borders;
  final Color borderColor;
  final double borderWidth;
  final double arcLength;

  /// Custom painter that creates the arc, its fill color and its borders.
  const ArcPainter({
    required this.finalValue,
    required this.currentValue,
    required this.barColor,
    required this.fillColor,
    required this.arcWidth,
    required this.borders,
    required this.borderColor,
    required this.borderWidth,
    required this.arcLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double fillLevel = 0;

    double startangle = 20 + arcLength;
    double sweepangle = 220 + arcLength * 2;

    /*  Fill value is calculated by dividing sweep angle of the curved bar
     into the number of steps needed to fill the progress bar and then 
    multiplied by the number of completed steps. */
    fillLevel = (((-pi / 180) * sweepangle) / finalValue) * currentValue;
    double fillAdjustment =
        0; // This is to adjust the starting point of the fill arc.

    for (int i = -20; i <= 70; i++) {
      if (arcLength == i) {
        break;
      }
      fillAdjustment++;
    }

    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20;
    final arcPaint = Paint()
      ..color = barColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20;

    if (borders) {
      // If borders are required.
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = arcWidth + borderWidth;
      // Arc to draw border
      canvas.drawArc(rect, (pi / 180) * startangle, (-pi / 180) * sweepangle,
          false, borderPaint);
      // Arc to draw the curved bar
      canvas.drawArc(rect, (pi / 180) * startangle, (-pi / 180) * sweepangle,
          false, arcPaint);
      // Arc to draw the filling of the curved bar
      canvas.drawArc(rect, (-pi / 180) * (sweepangle - fillAdjustment),
          -fillLevel, false, fillPaint);
    } else {
      // If borders are not required
      // Arc to draw the curved bar
      canvas.drawArc(rect, (pi / 180) * 20, (-pi / 180) * 200, false, arcPaint);
      // Arc to draw the filling of the curved bar
      canvas.drawArc(rect, (-pi / 180) * 200, -fillLevel, false, fillPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
