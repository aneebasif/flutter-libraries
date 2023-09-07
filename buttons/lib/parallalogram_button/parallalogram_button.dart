import 'package:flutter/material.dart';
import 'package:weoveri_button/parallalogram_button/parallalogram_painter.dart';

/// This defines the tilt side for it to be on the right or left side
enum TiltSide {
  left,
  right,
}

/// A button that is tilt from sides and accept a `Text` in the center
class ParallalogramButton extends StatelessWidget {
  const ParallalogramButton({
    Key? key,
    this.onPressed,
    this.buttonColor = Colors.black,
    this.borderColor,
    this.borderWdth = 1,
    this.margin,
    this.height = 50,
    this.width,
    this.boxShadow,
    this.tilt = 10,
    required this.text,
    this.textStyle,
    this.textMargin,
    this.tiltSide = TiltSide.right,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Color buttonColor;
  final List<BoxShadow>? boxShadow;
  final Color? borderColor;
  final double borderWdth;
  final EdgeInsetsGeometry? margin;
  final double height;
  final double? width;
  final double tilt;
  final TextStyle? textStyle;
  final EdgeInsets? textMargin;
  final TiltSide? tiltSide;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(boxShadow: boxShadow),
      child: GestureDetector(
        onTap: onPressed!,
        child: CustomPaint(
          painter: MyParallelogram(
            tilt: tiltSide == TiltSide.right ? tilt : -tilt,
            borderColor: borderColor ?? buttonColor,
            borderWidth: borderWdth,
            buttonColor: buttonColor,
          ),
          child: Center(
            child: Padding(
              padding: textMargin ??
                  const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
              child: Text(
                text,
                style: textStyle ??
                    const TextStyle(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
