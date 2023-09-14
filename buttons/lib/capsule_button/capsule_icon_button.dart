import 'package:flutter/material.dart';
import 'package:weoveri_button/capsule_button/woi_button_style.dart';

import '../enums.dart';
import 'base_capsule_button.dart';

/// An all in one capsule button
class WoiCapsuleIconButton extends StatelessWidget {
  WoiCapsuleIconButton({
    Key? key,
    required this.text,
    this.onTap,
    required this.icon,
    this.textStyle,
    this.borderColor,
    this.heigth,
    this.width,
    this.fillColor,
    this.iconLocation = WidgetLocation.start,
    this.boxShadowList,
    this.borderWidth = 1,
    this.isDisabled = false,
  }) : super(key: key);
  final String? text;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double? heigth;
  final Color? fillColor;
  final double? width;
  final WidgetLocation iconLocation;
  final Widget icon;
  final List<BoxShadow>? boxShadowList;
  final Color disabledColor = const Color(0xffD9D9D9);
  final bool isDisabled;
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
        widget: icon,
        height: heigth,
        widgetLocation: iconLocation,
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
