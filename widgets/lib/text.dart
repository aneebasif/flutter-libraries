import 'package:flutter/material.dart';

/// Animation that displays a [text] element, coloring it to look like sloshing
/// water is filling it up.
///
/// ![TextLiquidFill example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/text_liquid_fill.gif)
class TextLiquidFill extends StatefulWidget {
  /// Gives [TextStyle] to the text string.
  ///
  /// By default it is `TextStyle(fontSize: 140, fontWeight: FontWeight.bold)`
  final TextStyle textStyle;

  /// Specifies the backgroundColor of the box
  ///
  /// By default it is set to black color
  final Color boxBackgroundColor;

  /// Specifies the color of the wave
  ///
  /// By default it is set to blueAccent color
  final Color fillColor;

  final Color textColor;

  /// Specifies the load limit: (0, 1.0].  This may be used to limit the liquid
  /// fill effect to less than 100%.
  ///
  /// By default, the animation will load to 1.0 (100%).
  final double progressValue;

  final double size;

  const TextLiquidFill({
    Key? key,
    this.textStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.boxBackgroundColor = Colors.black,
    this.fillColor = Colors.blueAccent,
    this.textColor = Colors.white,
    this.progressValue = 0.27,
    this.size = 150,
  })  : assert(progressValue > 0 && progressValue <= 1.0),
        super(key: key);

  /// Creates the mutable state for this widget. See [StatefulWidget.createState].
  @override
  State<TextLiquidFill> createState() => _TextLiquidFillState();
}

class _TextLiquidFillState extends State<TextLiquidFill> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          color: widget.textColor,
          height: widget.size - 50 /* ß */,
          width: widget.size + 17 /* - (57) */,
          child: CustomPaint(
            painter: _WavePainter(
              fillColor: widget.fillColor,
              progressValue: widget.progressValue,
            ),
          ),
        ),
        SizedBox(
          height: widget.size /* - (100) */,
          // width: widget.size /* - (40) */,
          child: ShaderMask(
            blendMode: BlendMode.srcOut,
            shaderCallback: (bounds) => LinearGradient(
              colors: [widget.boxBackgroundColor],
              stops: const [0.0],
            ).createShader(bounds),
            child: Center(
              child: Text(
                (widget.progressValue * 100).toStringAsFixed(0),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 200,
                  letterSpacing: 0,
                  wordSpacing: 0,
                  height: 0.1,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _WavePainter extends CustomPainter {
  final Color fillColor;
  final double progressValue;

  _WavePainter({
    required this.fillColor,
    required this.progressValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final wavePaint = Paint()
      ..color = fillColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;
    double fillHeight = size.height - (progressValue * size.height);
    final path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width, fillHeight)
      ..lineTo(0.0, fillHeight + 20)
      ..lineTo(0.0, size.height)
      ..close();
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
