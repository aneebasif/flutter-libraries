import 'package:flutter/material.dart';

/// An all in one capsule button
class WoiCapsuleGradientButton extends StatelessWidget {
  const WoiCapsuleGradientButton({
    Key? key,
    required this.text,
    required this.onTap,
    // this.borderRadius = 50,
    this.textStyle,
    this.borderColor,
    this.heigth,
    this.width,
    required this.gradient,
    this.isDisabled = false,
  }) : super(key: key);
  // final double borderRadius;
  final String? text;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double? heigth;
  final Gradient? gradient;
  final double? width;
  final bool isDisabled;

  final Color disabledColor = const Color(0xffD9D9D9);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: isDisabled ? disabledColor : borderColor ?? Colors.black,
          ),
        ),
        height: heigth ?? 38,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _textContainer(),
          ],
        ),
      ),
    );
  }

  Widget _textContainer() {
    return Text(
      text!,
      overflow: TextOverflow.ellipsis,
      style: textStyle ??
          const TextStyle(
            height: 1,
            color: Colors.white,
            fontSize: 11,
          ),
      textAlign: TextAlign.center,
    );
  }
}
