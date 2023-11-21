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

  /// Specifies the load limit: (0, 1.0].  This may be used to limit the liquid
  /// fill effect to less than 100%.
  ///
  /// By default, the animation will load to 1.0 (100%).
  final int progressValue;

  final int tiltValue;

  final Color unFillColor;

  // final double size;

  const TextLiquidFill({
    Key? key,
    required this.textStyle,
    this.boxBackgroundColor = Colors.black,
    this.fillColor = Colors.blueAccent,
    this.progressValue = 27,
    this.tiltValue = 0,
    this.unFillColor = Colors.black,
    // this.size = 150,
  })  : assert(progressValue >= 0 && progressValue <= 100),
        super(key: key);

  /// Creates the mutable state for this widget. See [StatefulWidget.createState].
  @override
  State<TextLiquidFill> createState() => _TextLiquidFillState();
}

class _TextLiquidFillState extends State<TextLiquidFill> {
  @override
  Widget build(BuildContext context) {
    String textValue =
        widget.progressValue == 0 ? '00' : widget.progressValue.toString();
    final textPainter = TextPainter(
      text: TextSpan(
        text: textValue,
        style: widget.textStyle,
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
        maxWidth: double.infinity); // This will make the size available.
    // print(textPainter.size);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        /*  widget.progressValue == 100
            ? Container(
                width: textPainter.size.width,
                height: textPainter.size.height,
                color: widget.fillColor,
              )
            :  */
        Container(
          color: widget.unFillColor,
          child: CustomPaint(
            size: Size(textPainter.size.width,
                textPainter.size.height - (textPainter.size.height * .35)),
            painter: _WavePainter(
              fillColor: widget.fillColor,
              progressValue: widget.progressValue / 100,
              tiltValue: widget.tiltValue,
            ),
          ),
        ),
        ShaderMask(
          blendMode: BlendMode.srcOut,
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              widget.boxBackgroundColor.withOpacity(1),
            ],
            stops: const [0.0],
          ).createShader(bounds),
          child: Container(
            height: textPainter.size.height,
            color: Colors.white.withOpacity(0.01),
            child: Text(
              textValue,
              textAlign: TextAlign.center,
              style: widget.textStyle,
            ),
          ),
        ),
      ],
    );
  }
}

class _WavePainter extends CustomPainter {
  final Color fillColor;
  final double progressValue;
  final int tiltValue;
  // final Color textColor;

  _WavePainter({
    required this.fillColor,
    required this.progressValue,
    this.tiltValue = 0,
    // this.textColor = Colors.black,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final wavePaint = Paint()
      ..color = /* Colors.red */ fillColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;
    double fillHeight = size.height - (progressValue * size.height);
    if (fillHeight < 0) {
      fillHeight = 0;
    }
    final path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width, fillHeight)
      ..lineTo(
          0.0,
          //
          // fillHeight
          //
          (fillHeight + (tiltValue)) > size.height
              ? size.height
              : (fillHeight + tiltValue))
      ..lineTo(0.0, size.height)
      ..close();
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
