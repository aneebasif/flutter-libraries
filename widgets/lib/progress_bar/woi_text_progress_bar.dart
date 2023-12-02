import 'package:flutter/material.dart';

/// The [WOITextBar] is a progress bar variation that has a text depicting progress which fills up based on the progress value.
///
/// Here is an example of the [WOITextBar]
///
/// ```dart
/// const SizedBox(
///       child: WOITextBar(
///         progressValue: 10,
///         tiltValue: 0,
///         borderRadius: 30,
///         textStyle: TextStyle(
///           fontSize: 150,
///           fontWeight: FontWeight.bold,
///           height: 0,
///         ),
///         boxBackgroundColor: Colors.red,
///         fillColor: Colors.orange,
///         textColor: Colors.black,
///       ),
///     ),
/// ```
///
/// The size of the [WOITextBar] is adjusted by the font size of the widget.
/// The progress value is a required field and should be between 0 and 100 inclusive.

class WOITextBar extends StatefulWidget {
  /// Styling of the text. To change color of the text use [WOITextBar]'s textColor property.
  final TextStyle textStyle;

  /// Change color of the background of the widget. By default the color is yellow.
  final Color boxBackgroundColor;

  /// This is the color that fills up the text as the progress value increases.
  final Color fillColor;

  /// This is a required field that changes the progress being tracked by the [WOITextBar].
  final int progressValue;

  /// Tilt value changes the tilt of the fill color. By default value is 0 which means no tilt. Negative value will give right tilt and positive value will give left tilt.
  final int tiltValue;

  /// This is used to change the color of the text.
  final Color textColor;

  /// This changes the border radius of the background of the [WOITextBar]. It cannot be more than 30.
  final double borderRadius;

  const WOITextBar({
    Key? key,
    this.textStyle = const TextStyle(
      fontSize: 150,
      fontWeight: FontWeight.bold,
      height: 0,
    ),
    this.boxBackgroundColor = Colors.yellow,
    this.fillColor = Colors.blueAccent,
    required this.progressValue,
    this.tiltValue = 0,
    this.textColor = Colors.black,
    this.borderRadius = 20,
  })  : assert(progressValue >= 0 && progressValue <= 100,
            "Progress value should be between 0 and 100 inclusive"),
        assert(borderRadius <= 30, "Border radius should be less than 30"),
        super(key: key);
  @override
  State<WOITextBar> createState() => _WOITextBarState();
}

class _WOITextBarState extends State<WOITextBar> {
  bool isTilt = true;

  @override
  Widget build(BuildContext context) {
    String textValue = widget.progressValue.toString();
    if (textValue.length == 1) {
      textValue = '0${widget.progressValue.toString()}';
    }
    if (widget.progressValue == 0 || widget.progressValue == 100) {
      isTilt = false;
    }
    final textPainter = TextPainter(
      text: TextSpan(
        text: textValue,
        style: widget.textStyle,
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: double.infinity);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: widget.textColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: CustomPaint(
            size: Size(
              textPainter.size.width,
              textPainter.size.height - (textPainter.size.height * .35),
            ),
            painter: _WavePainter(
              fillColor: widget.fillColor,
              progressValue: widget.progressValue / 100,
              tiltValue: isTilt ? widget.tiltValue : 0,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: ShaderMask(
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
        ),
      ],
    );
  }
}

class _WavePainter extends CustomPainter {
  final Color fillColor;
  final double progressValue;
  final int tiltValue;

  _WavePainter({
    required this.fillColor,
    required this.progressValue,
    this.tiltValue = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final wavePaint = Paint()
      ..color = fillColor
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
