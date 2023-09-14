import 'package:flutter/material.dart';
import 'package:weoveri_button/capsule_button/woi_button_style.dart';
import 'base_capsule_button.dart';

/// A gradient capsule button
class WoiCapsuleGradientButton extends StatelessWidget {
  const WoiCapsuleGradientButton({
    Key? key,
    required this.text,
    this.onTap,
    this.textStyle,
    this.borderColor,
    this.heigth,
    this.width,
    this.boxShadowList,
    required this.gradient,
    this.borderWidth = 1,
    this.isDisabled = false,
  }) : super(key: key);
  final String? text;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double? heigth;
  final Gradient? gradient;
  final double? width;
  final List<BoxShadow>? boxShadowList;
  final Color disabledColor = const Color(0xffD9D9D9);
  final double borderWidth;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return WoiBaseButton(
      onTap: () {
        if (isDisabled) {
          return;
        }
        onTap!();
      },
      buttonStyle: WoiButtonStyle(
        gradient: gradient,
        text: text,
        height: heigth,
        width: width,
        boxShadow: boxShadowList,
        textStyle: textStyle,
        border: Border.all(
          color: borderColor ?? Colors.black,
          width: borderWidth,
        ),
      ),
    );
  }
}
