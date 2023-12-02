import 'package:flutter/material.dart';

/// Custom painter that creates the sections of the section bar and also if needed then its borders as well.
class SectionBarPainter extends CustomPainter {
  final Color barColor;
  final Color borderColor;
  final double borderWidth;
  final double tiltValue;
  final bool borderedSections;

  SectionBarPainter({
    this.barColor = Colors.grey,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
    this.tiltValue = 5,
    this.borderedSections = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 1
      ..color = barColor
      ..style = PaintingStyle.fill;
    Paint paint2 = Paint()
      ..strokeWidth = borderWidth
      ..color = borderColor
      ..style = PaintingStyle.stroke;

    Path path = Path();
    //Right tilt and no tilt
    if (tiltValue >= 0) {
      path.moveTo(tiltValue, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width - tiltValue, size.height);
      path.lineTo(0, size.height);
      path.close();
    } // Left tilt
    else if (tiltValue < 0) {
      path.moveTo(0, 0);
      path.lineTo(size.width - tiltValue.abs(), 0);
      path.lineTo(size.width, size.height);
      path.lineTo(tiltValue.abs(), size.height);
      path.close();
    }

    canvas.drawPath(path, paint);
    if (borderedSections) {
      canvas.drawPath(path, paint2);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
