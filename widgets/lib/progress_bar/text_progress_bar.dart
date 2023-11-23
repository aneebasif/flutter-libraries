import 'package:flutter/material.dart';

class WOITextBar extends StatefulWidget {
  final TextStyle textStyle;
  final Color boxBackgroundColor;
  final Color fillColor;
  final int progressValue;
  final int tiltValue;
  final Color textColor;
  final double borderRadius;

  const WOITextBar({
    Key? key,
    required this.textStyle,
    this.boxBackgroundColor = Colors.black,
    this.fillColor = Colors.blueAccent,
    this.progressValue = 27,
    this.tiltValue = 0,
    this.textColor = Colors.black,
    this.borderRadius = 20,
  })  : assert(progressValue >= 0 && progressValue <= 100,
            "Progress value should be between 0 and 100 inclusive"),
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
              /*         Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ).merge(textStyle),
        ),
        Text(
          text,
          style:  TextStyle(
              color: textColor
          ).merge(textStyle),
        ),
      ],
    ), */
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
