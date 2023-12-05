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
  });

  @override
  void paint(Canvas canvas, Size size) {
    double fillLevel = 0;

    /*  Fill value is calculated by dividing sweep angle of the curved bar
     into the number of steps needed to fill the progress bar and then 
    multiplied by the number of completed steps. */
    fillLevel = (((-pi / 180) * 220) / finalValue) * currentValue;

    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);

    if (borders) {
      // If borders are required.
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
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = arcWidth + borderWidth;
      // Arc to draw border
      canvas.drawArc(
          rect, (pi / 180) * 20, (-pi / 180) * 220, false, borderPaint);
      // Arc to draw the curved bar
      canvas.drawArc(rect, (pi / 180) * 20, (-pi / 180) * 220, false, arcPaint);
      // Arc to draw the filling of the curved bar
      canvas.drawArc(rect, (-pi / 180) * 200, -fillLevel, false, fillPaint);
    } else {
      // If borders are not required
      final paint2 = Paint()
        ..color = fillColor
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 20;
      final paint = Paint()
        ..color = barColor
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 20;

// Arc to draw the curved bar
      canvas.drawArc(rect, (pi / 180) * 20, (-pi / 180) * 200, false, paint);
      // Arc to draw the filling of the curved bar
      canvas.drawArc(rect, (-pi / 180) * 200, -fillLevel, false, paint2);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
