import 'package:flutter/material.dart';
import 'package:weoveri_button/capsule_button/woi_button_style.dart';

import 'base_capsule_button.dart';

/// An all in one capsule button
class WoiCapsuleButton extends StatelessWidget {
  WoiCapsuleButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.textStyle,
    this.borderColor,
    this.heigth,
    this.width,
    this.fillColor,
    this.isDisabled = false,
    this.boxShadowList,
    this.borderWidth = 1,
  }) : super(key: key);
  final String? text;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double? heigth;
  final Color? fillColor;
  final double? width;
  final bool isDisabled;
  final List<BoxShadow>? boxShadowList;
  final double borderWidth;

  final WoiButtonStyle buttonStyle = WoiButtonStyle(
    border: Border.all(
      color: Colors.black,
    ),
    backgroundColor: Colors.black,
    borderRadius: BorderRadius.circular(50),
  );

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
        backgroundColor: fillColor ?? buttonStyle.backgroundColor,
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
    /* InkWell(
      onTap: isDisabled ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDisabled ? disabledColor : fillColor ?? Colors.black,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: isDisabled ? disabledColor : borderColor ?? Colors.black,
          ),
          boxShadow: boxShadowList,
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
    ); */
  }
/* 
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
  } */
}
